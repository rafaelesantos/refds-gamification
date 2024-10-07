import Foundation
import RefdsShared
import RefdsInjection

public actor Gamification: GamificationProtocol {
    private var center: GamificationCenter? {
        get async { await getCenter() }
    }
    
    @MainActor
    private let gameCenter: GameCenter = .init()
    
    public func signIn() async throws -> GameCenterUserProtocol {
        try await gameCenter.authenticate()
        var user = await gameCenter.getUser()
        let photo = try await gameCenter.getPhoto()
        user.photo = photo
        
        var center = await center
        center?.gameCenterUser = user
        await setCenter(center)
        
        return user
    }
    
    public func reportTask(for taskIdentifier: GamificationIdentifierProtocol) async -> [GamificationIdentifierProtocol] {
        guard var center = await center,
              let task = center.tasks[taskIdentifier.id]
        else { return [] }
        let completed = center.completed
        center.tasks[taskIdentifier.id]?.completedDate = .now
        
        center.score.value += task.score.value
        center.coin.value += task.coin.value
        
        center.completed[taskIdentifier.id] = true
        await setCenter(center)
        await setCenter(checkCompleted(missions: Array(center.missions.values), on: center))
        await setCenter(checkCompleted(challenges: Array(center.challenges.values), on: center))
        let updateCompletedIDs = center.completed.filter { $0.value == true }.compactMap {
            completed[$0.key] != $0.value ? $0.key : nil
        }
        return await getIdentifiers(with: updateCompletedIDs)
    }
    
    
    public func reportSequence(for sequenceIdentifier: GamificationIdentifierProtocol) async {
        guard var center = await center else { return }
        guard let maxDate = center.sequences[sequenceIdentifier.id]?.historic.max(),
              let day = Calendar.current.dateComponents([.day], from: maxDate, to: .now).day
        else {
            center.sequences[sequenceIdentifier.id]?.historic = [.now]
            return
        }
        let historic = center.sequences[sequenceIdentifier.id]?.historic ?? []
        center.sequences[sequenceIdentifier.id]?.historic = day != .zero ? [] : historic + [.now]
        await setCenter(center)
    }
    
    public func getCenter() async -> GamificationCenter? {
        await RefdsDefaults.get(for: "refds.gamification.center.\(RefdsApplication().id ?? "")")
    }
    
    private func setCenter(_ center: GamificationCenter?) async {
        await RefdsDefaults.set(
            center,
            for: "refds.gamification.center.\(RefdsApplication().id ?? "")"
        )
    }
    
    private func checkCompleted(
        missions: [GamificationMissionProtocol],
        on center: GamificationCenter?
    ) -> GamificationCenter? {
        guard var center = center else { return nil }
        var completed = center.completed
        missions.forEach { mission in
            if center.completed[mission.id] != true {
                let isCompleted = mission.tasks.allSatisfy { center.completed[$0.id] == true }
                center.score.value += isCompleted ? mission.score.value : .zero
                center.coin.value += isCompleted ? mission.coin.value : .zero
                completed[mission.id] = isCompleted
            }
        }
        center.completed = completed
        return center
    }
    
    private func checkCompleted(
        challenges: [GamificationChallengeProtocol],
        on center: GamificationCenter?
    ) -> GamificationCenter? {
        guard var center = center else { return nil }
        var completed = center.completed
        challenges.forEach { challenge in
            if center.completed[challenge.id] != true {
                let isCompleted = challenge.missions.allSatisfy { center.completed[$0.id] == true }
                center.score.value += isCompleted ? challenge.score.value : .zero
                center.coin.value += isCompleted ? challenge.coin.value : .zero
                completed[challenge.id] = isCompleted
            }
        }
        center.completed = completed
        return center
    }
    
    private func getIdentifiers(with ids: [String]) async -> [GamificationIdentifierProtocol] {
        guard let center = await center else { return [] }
        var identifiers = [GamificationIdentifierProtocol]()
        ids.forEach { id in
            if let identifier = center.challenges[id] ??
                center.missions[id] ??
                center.tasks[id] ??
                center.sequences[id] {
                identifiers += [identifier]
            }
        }
        return identifiers
    }
}
