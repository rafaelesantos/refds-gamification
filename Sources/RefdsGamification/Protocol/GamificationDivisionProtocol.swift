import Foundation
import SwiftUI
import RefdsShared

public protocol GamificationDivisionProtocol: GamificationIdentifierProtocol {
    var level: GamificationLevel { get }
    var coin: GamificationRewardProtocol { get }
    var score: GamificationRewardProtocol { get }
}

public extension GamificationDivisionProtocol {
    var category: GamificationCategory { .division }
}
