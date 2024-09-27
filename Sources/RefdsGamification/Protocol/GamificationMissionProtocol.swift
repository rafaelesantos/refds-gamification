import Foundation
import SwiftUI
import RefdsShared

public protocol GamificationMissionProtocol: GamificationIdentifierProtocol {
    var level: GamificationLevel { get }
    var tasks: [GamificationTaskProtocol] { get }
    var coin: GamificationRewardProtocol { get }
    var total: Int { get }
    var current: Int { get }
    var isCompleted: Bool { get }
    var completedTasks: [GamificationTaskProtocol] { get }
    var score: GamificationRewardProtocol { get }
    var completedDate: Date? { get }
}

public extension GamificationMissionProtocol {
    var category: GamificationCategory { .mission }
}
