import Foundation
import RefdsShared

public protocol GamificationProtocol {
    var center: GamificationCenter? { get }
    func signIn(completion: @escaping (RefdsResult<GameCenterUserProtocol>) -> Void)
    func reportSequence(for sequenceIdentifier: GamificationIdentifierProtocol)
    func reportTask(
        for taskIdentifier: GamificationIdentifierProtocol,
        completion: @escaping ([GamificationIdentifierProtocol]) -> Void
    )
}
