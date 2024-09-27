import Foundation
import SwiftUI
import RefdsShared

public struct GamificationDivision: GamificationDivisionProtocol {
    public var id: String
    public var title: String?
    public var description: String
    public var badge: GamificationBadgeProtocol?
    public var level: GamificationLevel
    public var coin: GamificationRewardProtocol
    public var score: GamificationRewardProtocol
    
    public init(
        id: String,
        title: String? = nil,
        description: String,
        badge: GamificationBadgeProtocol? = nil,
        level: GamificationLevel,
        coin: GamificationRewardProtocol,
        score: GamificationRewardProtocol
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.badge = badge
        self.level = level
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
        case coin
        case score
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        badge = try container.decodeIfPresent(GamificationBadge.self, forKey: .badge)
        level = try container.decode(GamificationLevel.self, forKey: .level)
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
        try container.encode(coin, forKey: .coin)
        try container.encode(score, forKey: .score)
    }
}
