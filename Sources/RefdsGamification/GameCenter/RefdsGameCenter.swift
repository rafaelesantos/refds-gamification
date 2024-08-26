import SwiftUI
import RefdsShared
import GameKit

final class RefdsGameCenter: NSObject, GKGameCenterControllerDelegate {
    private var signInViewController: RefdsViewController? {
        didSet { presentSignIn() }
    }
    
    var localPlayer: GKLocalPlayer {
        .local
    }
    
    func authenticate(completion: @escaping (RefdsResult<Void>) -> Void) {
        let localPlayer = localPlayer
        localPlayer.authenticateHandler = nil
        localPlayer.authenticateHandler = { [weak self] viewController, error in
            if localPlayer.isAuthenticated {
                completion(.success(()))
            } else if let viewController = viewController {
                self?.signInViewController = viewController.refdsViewController
            } else if let error = error {
                completion(.failure(error.refdsError))
            }
        }
    }
    
    private func presentSignIn() {
        RefdsApplication.shared.rootViewController?.present(signInViewController)
    }
    
    func reportAchievement(
        for identifier: GamificationIdentifier,
        percentComplete: Double,
        completion: @escaping (RefdsResult<Void>) -> Void
    ) {
        let achievement = GKAchievement(identifier: identifier.id)
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
    
    func resetAchievements() {
        GKAchievement.resetAchievements()
    }
    
    func showAchievements() {
        let viewController = GKGameCenterViewController(state: .achievements)
        viewController.gameCenterDelegate = self
        
        RefdsApplication.shared.rootViewController?.present(viewController.refdsViewController)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        #if os(macOS)
        gameCenterViewController.dismiss(gameCenterViewController)
        #else
        gameCenterViewController.dismiss(animated: true)
        #endif
    }
    
    func loadPhoto(completion: @escaping (RefdsResult<Data?>) -> Void) {
        localPlayer.loadPhoto(for: .normal) { uiImage, error in
            if let uiImage = uiImage {
                #if os(macOS)
                #else
                return completion(.success(uiImage.pngData()))
                #endif
            }
            completion(.failure(.custom(message: error?.localizedDescription ?? "loadPhoto")))
        }
    }
}
