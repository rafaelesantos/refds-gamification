import Foundation
import RefdsShared

public protocol GamificationReward: GamificationIdentifier {
    var value: Int { get set }
}
