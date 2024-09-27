import Foundation
import RefdsShared
import RefdsInjection

public final class Gamification: GamificationProtocol {
    @RefdsDefaults(key: "refds.gamification.center.\(RefdsApplication.shared.id ?? "")")
    public var center: GamificationCenter?
    
    private let gameCenter: GameCenter = .init()
    private let task: RefdsTask = .init(
        label: "refds.gamification",
        qos: .background,
        attributes: []
    )
    
    public init() {}
    
    public func signIn(completion: @escaping (RefdsResult<GameCenterUserProtocol>) -> Void) {
        gameCenter.authenticate { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                var user = GameCenterUser(
                    name: self.gameCenter.localPlayer.displayName,
                    alias: self.gameCenter.localPlayer.alias
                )
                
                self.gameCenter.loadPhoto(completion: { result in
                    switch result {
                    case .success(let photo): user.photo = photo
                    case .failure: break
                    }
                    self.center?.gameCenterUser = user
                    completion(.success(user))
                })
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func reportTask(
        for taskIdentifier: GamificationIdentifierProtocol,
        completion: @escaping ([GamificationIdentifierProtocol]) -> Void
    ) {
        let item = { [weak self] in
            guard let self = self,
                  var center = self.center,
                  let task = center.tasks[taskIdentifier.id]
            else { return }
            let completed = center.completed
            center.tasks[taskIdentifier.id]?.completedDate = .now
            
            center.score.value += task.score.value
            center.coin.value += task.coin.value
            
            center.completed[taskIdentifier.id] = true
            self.center = center
            self.center = checkCompleted(missions: Array(center.missions.values), on: center)
            self.center = checkCompleted(challenges: Array(center.challenges.values), on: center)
            let updateCompletedIDs = center.completed.filter { $0.value == true }.compactMap {
                completed[$0.key] != $0.value ? $0.key : nil
            }
            
            completion(getIdentifiers(with: updateCompletedIDs))
        }
        
        task.execute(items: [item])
    }
    
    public func reportSequence(for sequenceIdentifier: GamificationIdentifierProtocol) {
        let item = { [weak self] in
            guard let self = self, var center = self.center else { return }
            guard let maxDate = center.sequences[sequenceIdentifier.id]?.historic.max(),
                  let day = Calendar.current.dateComponents([.day], from: maxDate, to: .now).day
            else {
                center.sequences[sequenceIdentifier.id]?.historic = [.now]
                return
            }
            let historic = center.sequences[sequenceIdentifier.id]?.historic ?? []
            center.sequences[sequenceIdentifier.id]?.historic = day != .zero ? [] : historic + [.now]
            self.center = center
        }
        
        task.execute(items: [item])
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
    
    private func getIdentifiers(with ids: [String]) -> [GamificationIdentifierProtocol] {
        guard let center = center else { return [] }
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
