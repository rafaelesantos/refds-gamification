import Foundation
import RefdsShared

public struct GamificationSequence: GamificationSequenceProtocol {
    public var id: String
    public var title: String?
    public var description: String
    public var badge: GamificationBadgeProtocol?
    public var counter: Int
    public var historic: [Date]
    
    public init(
        id: String,
        title: String? = nil,
        description: String,
        badge: GamificationBadgeProtocol? = nil,
        counter: Int,
        historic: [Date]
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.badge = badge
        self.counter = counter
        self.historic = historic
    }
    
    enum CodingKeys: CodingKey {
        case id
        case category
        case title
        case description
        case badge
        case counter
        case historic
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        badge = try container.decodeIfPresent(GamificationBadge.self, forKey: .badge)
        counter = try container.decode(Int.self, forKey: .counter)
        historic = try container.decode([Date].self, forKey: .historic)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(category, forKey: .category)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(badge as? GamificationBadge, forKey: .badge)
        try container.encode(counter, forKey: .counter)
        try container.encode(historic, forKey: .historic)
    }
}
