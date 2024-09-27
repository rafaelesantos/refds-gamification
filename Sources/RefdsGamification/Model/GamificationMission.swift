import Foundation
import SwiftUI
import RefdsShared

public struct GamificationMission: GamificationMissionProtocol {
    public var id: String
    public var title: String?
    public var description: String
    public var badge: GamificationBadgeProtocol?
    public var level: GamificationLevel
    public var tasks: [GamificationTaskProtocol]
    public var coin: GamificationRewardProtocol
    public var score: GamificationRewardProtocol
    
    public var total: Int {
        tasks.count
    }
    
    public var current: Int {
        completedTasks.count
    }
    
    public var completedTasks: [GamificationTaskProtocol] {
        tasks.filter(\.isCompleted)
    }
    
    public var completedDate: Date? {
        tasks.allSatisfy(\.isCompleted) ?
        tasks.max(by: { $0.completedDate ?? .now < $1.completedDate ?? .now })?.completedDate : nil
    }
    
    public var isCompleted: Bool {
        completedDate != nil
    }
    
    public init(
        id: String,
        title: String? = nil,
        description: String,
        badge: GamificationBadgeProtocol? = nil,
        level: GamificationLevel,
        tasks: [GamificationTaskProtocol],
        coin: GamificationRewardProtocol,
        score: GamificationRewardProtocol
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.badge = badge
        self.level = level
        self.tasks = tasks
        self.coin = coin
        self.score = score
    }
    
    enum CodingKeys: CodingKey {
        case id
        case category
        case title
        case description
        case badge
        case level
        case tasks
        case coin
        case total
        case current
        case isCompleted
        case completedTasks
        case score
        case completedDate
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        badge = try container.decodeIfPresent(GamificationBadge.self, forKey: .badge)
        level = try container.decode(GamificationLevel.self, forKey: .level)
        tasks = try container.decode([GamificationTask].self, forKey: .tasks)
        coin = try container.decode(GamificationReward.self, forKey: .coin)
        score = try container.decode(GamificationReward.self, forKey: .score)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(category, forKey: .category)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(badge as? GamificationBadge, forKey: .badge)
        try container.encode(level, forKey: .level)
        try container.encode(tasks as? [GamificationTask], forKey: .tasks)
        try container.encode(coin, forKey: .coin)
        try container.encode(total, forKey: .total)
        try container.encode(current, forKey: .current)
        try container.encode(isCompleted, forKey: .isCompleted)
        try container.encode(completedTasks as? [GamificationTask], forKey: .completedTasks)
        try container.encode(score, forKey: .score)
        try container.encodeIfPresent(completedDate, forKey: .completedDate)
    }
}
