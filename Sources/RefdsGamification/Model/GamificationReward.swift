import Foundation
import RefdsShared

public struct GamificationReward: GamificationRewardProtocol {
    public var id: String
    public var category: GamificationCategory
    public var title: String?
    public var description: String
    public var badge: GamificationBadgeProtocol?
    public var value: Int
    
    public init(
        id: String,
        category: GamificationCategory,
        title: String? = nil,
        description: String,
        badge: GamificationBadgeProtocol? = nil,
        value: Int
    ) {
        self.id = id
        self.category = category
        self.title = title
        self.description = description
        self.badge = badge
        self.value = value
    }
    
    enum CodingKeys: CodingKey {
        case id
        case category
        case title
        case description
        case badge
        case value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        category = try container.decode(GamificationCategory.self, forKey: .category)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        badge = try container.decodeIfPresent(GamificationBadge.self, forKey: .badge)
        value = try container.decode(Int.self, forKey: .value)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(category, forKey: .category)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(badge as? GamificationBadge, forKey: .badge)
        try container.encode(value, forKey: .value)
    }
}
