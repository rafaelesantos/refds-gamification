import Foundation
import RefdsShared

public protocol GamificationChallenge: GamificationIdentifier {
    var startDate: Date { get }
    var endDate: Date { get }
    var missions: [GamificationIdentifier] { get }
    var level: GamificationLevel { get }
    var score: Int { get }
    var coin: Int { get }
    var remainingTime: DateComponents { get }
    var isCompleted: Bool { get }
}

public extension GamificationChallenge {
    var category: GamificationCategory { .challenge }
}
