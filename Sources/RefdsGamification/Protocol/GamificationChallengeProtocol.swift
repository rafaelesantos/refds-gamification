import Foundation
import RefdsShared

public protocol GamificationChallengeProtocol: GamificationIdentifierProtocol {
    var startDate: Date { get }
    var endDate: Date { get }
    var missions: [GamificationMissionProtocol] { get }
    var level: GamificationLevel { get }
    var score: GamificationRewardProtocol { get }
    var coin: GamificationRewardProtocol { get }
    var remainingTime: DateComponents { get }
    var isCompleted: Bool { get }
}

public extension GamificationChallengeProtocol {
    var category: GamificationCategory { .challenge }
}
