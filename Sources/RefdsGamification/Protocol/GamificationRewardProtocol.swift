import Foundation
import RefdsShared

public protocol GamificationRewardProtocol: GamificationIdentifierProtocol {
    var value: Int { get set }
}
