import Foundation
import RefdsShared

public struct GamificationChallenge: GamificationChallengeProtocol {
    public var id: String
    public var title: String?
    public var description: String
    public var badge: GamificationBadgeProtocol?
    public var startDate: Date
    public var endDate: Date
    public var missions: [GamificationMissionProtocol]
    public var level: GamificationLevel
    public var score: GamificationRewardProtocol
    public var coin: GamificationRewardProtocol
    
    public var remainingTime: DateComponents {
        Calendar.current.dateComponents(
            [.day, .hour, .minute, .second],
            from: startDate,
            to: endDate
        )
    }
    
    public var isCompleted: Bool {
        missions.allSatisfy { $0.isCompleted }
    }
    
    public init(
        id: String,
        title: String? = nil,
        description: String,
        badge: GamificationBadgeProtocol? = nil,
        startDate: Date,
        endDate: Date,
        missions: [GamificationMissionProtocol],
        level: GamificationLevel,
        score: GamificationRewardProtocol,
        coin: GamificationRewardProtocol
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.badge = badge
        self.startDate = startDate
        self.endDate = endDate
        self.missions = missions
        self.level = level
        self.score = score
        self.coin = coin
    }
    
    enum CodingKeys: CodingKey {
        case id
        case category
        case title
        case description
        case badge
        case startDate
        case endDate
        case missions
        case level
        case score
        case coin
        case isCompleted
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        badge = try container.decodeIfPresent(GamificationBadge.self, forKey: .badge)
        startDate = try container.decode(Date.self, forKey: .startDate)
        endDate = try container.decode(Date.self, forKey: .endDate)
        missions = try container.decode([GamificationMission].self, forKey: .missions)
        level = try container.decode(GamificationLevel.self, forKey: .level)
        score = try container.decode(GamificationReward.self, forKey: .score)
        coin = try container.decode(GamificationReward.self, forKey: .coin)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(category, forKey: .category)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(badge as? GamificationBadge, forKey: .badge)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
        try container.encode(missions as? [GamificationMission], forKey: .missions)
        try container.encode(level, forKey: .level)
        try container.encode(score, forKey: .score)
        try container.encode(coin, forKey: .coin)
        try container.encode(isCompleted, forKey: .isCompleted)
    }
}
