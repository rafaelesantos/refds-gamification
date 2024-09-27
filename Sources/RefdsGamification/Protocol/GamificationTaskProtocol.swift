import Foundation
import RefdsShared

public protocol GamificationTaskProtocol: GamificationIdentifierProtocol {
    var level: GamificationLevel { get set }
    var score: GamificationRewardProtocol { get }
    var coin: GamificationRewardProtocol { get }
    var isCompleted: Bool { get }
    var completedDate: Date? { get set }
}

public extension GamificationTaskProtocol {
    var category: GamificationCategory { .task }
}
