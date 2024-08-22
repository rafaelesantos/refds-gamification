import Foundation
import GameKit

public struct GameCenterAchievementModel {
    public let identifier: String
    public let percentComplete: Double
    public let isCompleted: Bool
    public let lastReportedDate: Date
    
    public init(achievement: GKAchievement) {
        identifier = achievement.identifier
        percentComplete = achievement.percentComplete
        isCompleted = achievement.isCompleted
        lastReportedDate = achievement.lastReportedDate
    }
}
