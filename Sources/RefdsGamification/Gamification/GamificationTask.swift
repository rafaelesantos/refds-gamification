import Foundation
import RefdsShared

public protocol GamificationTask: GamificationIdentifier {
    var level: GamificationLevel { get set }
    var score: Int { get }
    var coin: Int { get }
    var isCompleted: Bool { get }
    var completedDate: Date? { get set }
}

public extension GamificationTask {
    var category: GamificationCategory { .task }
}
