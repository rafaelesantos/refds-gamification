import Foundation
import RefdsShared

public protocol GamificationSequenceProtocol: GamificationIdentifierProtocol {
    var counter: Int { get }
    var historic: [Date] { get set }
}

public extension GamificationSequenceProtocol {
    var category: GamificationCategory { .sequence }
}
