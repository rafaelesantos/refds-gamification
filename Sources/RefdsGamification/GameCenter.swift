import SwiftUI
import RefdsShared
import GameKit

@MainActor
class GameCenter: NSObject, GKGameCenterControllerDelegate {
    private var signInViewController: RefdsViewController? {
        didSet { presentSignIn() }
    }
    
    var localPlayer: GKLocalPlayer {
        get async { .local }
    }
    
    func getUser() async -> GameCenterUserProtocol {
        await GameCenterUser(
            name: localPlayer.displayName,
            alias: localPlayer.alias
        )
    }
    
    func authenticate() async throws {
        let localPlayer = await localPlayer
        localPlayer.authenticateHandler = nil
        try await withCheckedThrowingContinuation { [weak self] continuation in
            localPlayer.authenticateHandler = { viewController, error in
                Task {
                    if localPlayer.isAuthenticated {
                        continuation.resume(returning: ())
                    } else if let viewController = viewController {
                        self?.signInViewController = await viewController.refdsViewController
                    } else if let error = error {
                        continuation.resume(throwing: error.refdsError)
                    }
                }
            }
        }
    }
    
    private func presentSignIn() {
        Task {
            await RefdsApplication().rootViewController?.present(signInViewController)
        }
    }
    
    func reportAchievement(
        for identifier: GamificationIdentifierProtocol,
        percentComplete: Double
    ) async throws {
        let achievement = GKAchievement(identifier: identifier.id)
        achievement.percentComplete = percentComplete
        achievement.showsCompletionBanner = true
        try await GKAchievement.report([achievement])
    }
    
    func resetAchievements() async throws {
        try await GKAchievement.resetAchievements()
    }
    
    func showAchievements() async {
        let viewController = GKGameCenterViewController(state: .achievements)
        viewController.gameCenterDelegate = self
        
        await RefdsApplication().rootViewController?.present(viewController.refdsViewController)
    }
    
    nonisolated func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        Task {
            #if os(macOS)
            await gameCenterViewController.dismiss(gameCenterViewController)
            #else
            await gameCenterViewController.dismiss(animated: true)
            #endif
        }
    }
    
    func getPhoto() async throws -> Data? {
        let image = try await GKLocalPlayer.local.loadPhoto(for: .normal)
        return image.pngData()
    }
}

#if os(macOS)
extension NSBitmapImageRep {
    var png: Data? { representation(using: .png, properties: [:]) }
}

extension Data {
    var bitmap: NSBitmapImageRep? { NSBitmapImageRep(data: self) }
}

extension NSImage: @unchecked @retroactive Sendable {
    func pngData() -> Data? { tiffRepresentation?.bitmap?.png }
}
#endif
