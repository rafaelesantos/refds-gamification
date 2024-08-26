import Foundation
import SwiftUI
import RefdsShared

public protocol GamificationMission: GamificationIdentifier {
    var level: GamificationLevel { get }
    var tasks: [GamificationIdentifier] { get }
    var coin: Int { get }
    var total: Int { get }
    var current: Int { get }
    var isCompleted: Bool { get }
    var completedTasks: [GamificationIdentifier] { get }
    var score: Int { get }
    var completedDate: Date? { get }
}

public extension GamificationMission {
    var category: GamificationCategory { .mission }
}
