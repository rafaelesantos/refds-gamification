import SwiftUI
import RefdsShared
import GameKit

public final class RefdsGameCenter: NSObject, GKGameCenterControllerDelegate {
    public static let shared = RefdsGameCenter()
    
    public func authenticate(completion: @escaping (RefdsResult<Void>) -> Void) {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = { viewController, error in
            if localPlayer.isAuthenticated {
                completion(.success(()))
            } else if let viewController = viewController {
                RefdsApplication.shared.rootViewController?.present(viewController.refdsViewController)
            } else if let error = error {
                completion(.failure(error.refdsError))
            }
        }
    }
    
    public func reportAchievement(
        for identifier: GameCenterIdentifierProtocol,
        percentComplete: Double,
        completion: @escaping (RefdsResult<Void>) -> Void
    ) {
        let achievement = GKAchievement(identifier: identifier.rawValue)
        achievement.percentComplete = percentComplete
        achievement.showsCompletionBanner = true
        
        GKAchievement.report([achievement]) { error in
            if let error = error {
                completion(.failure(error.refdsError))
            } else {
                completion(.success(()))
            }
        }
    }
    
    public func showAchievements() {
        let viewController = GKGameCenterViewController(state: .achievements)
        viewController.gameCenterDelegate = self
        
        RefdsApplication.shared.rootViewController?.present(viewController.refdsViewController)
    }
    
    public func loadAchievements(completion: @escaping (RefdsResult<[GameCenterAchievementModel]>) -> Void) {
        GKAchievement.loadAchievements { achievements, error in
            if let error = error {
                completion(.failure(error.refdsError))
            } else if let achievements = achievements {
                let models = achievements.map { GameCenterAchievementModel(achievement: $0) }
                completion(.success(models))
            }
        }
    }
    
    public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        #if os(macOS)
        gameCenterViewController.dismiss(gameCenterViewController)
        #else
        gameCenterViewController.dismiss(animated: true)
        #endif
    }
    
    public func getPhoto() -> Image? {
        var image: Image?
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global(qos: .background).async {
            GKLocalPlayer.local.loadPhoto(for: .normal) { uiImage, error in
                if let uiImage = uiImage {
                    image = Image(uiImage: uiImage)
                }
                group.leave()
            }
        }
        group.wait()
        return image
    }
}
