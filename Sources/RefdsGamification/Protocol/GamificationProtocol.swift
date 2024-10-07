import Foundation
import RefdsShared

public protocol GamificationProtocol {
    func getCenter() async -> GamificationCenter?
    func signIn() async throws -> GameCenterUserProtocol
    func reportSequence(for sequenceIdentifier: GamificationIdentifierProtocol) async
    func reportTask(for taskIdentifier: GamificationIdentifierProtocol) async -> [GamificationIdentifierProtocol]
}
