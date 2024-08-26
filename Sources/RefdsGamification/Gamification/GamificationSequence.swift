import Foundation
import RefdsShared

public protocol GamificationSequence: GamificationIdentifier {
    var counter: Int { get }
    var historic: [Date] { get set }
}

public extension GamificationSequence {
    var category: GamificationCategory { .sequence }
}
