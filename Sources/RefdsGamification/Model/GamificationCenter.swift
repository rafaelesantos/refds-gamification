import Foundation
import RefdsShared

public struct GamificationCenter: GamificationCenterProtocol {
    public var gameCenterUser: GameCenterUserProtocol?
    public var division: GamificationDivisionProtocol
    public var score: GamificationRewardProtocol
    public var coin: GamificationRewardProtocol
    
    public var sequences: [String: GamificationSequenceProtocol]
    public var missions: [String: GamificationMissionProtocol]
    public var challenges: [String: GamificationChallengeProtocol]
    public var tasks: [String: GamificationTaskProtocol]
    public var completed: [String: Bool]
    
    public init(
        gameCenterUser: GameCenterUserProtocol? = nil,
        division: GamificationDivisionProtocol,
        score: GamificationRewardProtocol,
        coin: GamificationRewardProtocol,
        sequences: [String : GamificationSequenceProtocol],
        missions: [String : GamificationMissionProtocol],
        challenges: [String : GamificationChallengeProtocol],
        tasks: [String : GamificationTaskProtocol],
        completed: [String : Bool]
    ) {
        self.gameCenterUser = gameCenterUser
        self.division = division
        self.score = score
        self.coin = coin
        self.sequences = sequences
        self.missions = missions
        self.challenges = challenges
        self.tasks = tasks
        self.completed = completed
    }
    
    enum CodingKeys: CodingKey {
        case gameCenterUser
        case division
        case score
        case coin
        case sequences
        case missions
        case challenges
        case tasks
        case completed
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gameCenterUser = try container.decodeIfPresent(GameCenterUser.self, forKey: .gameCenterUser)
        division = try container.decode(GamificationDivision.self, forKey: .division)
        score = try container.decode(GamificationReward.self, forKey: .score)
        coin = try container.decode(GamificationReward.self, forKey: .coin)
        sequences = try container.decode([String: GamificationSequence].self, forKey: .sequences)
        missions = try container.decode([String: GamificationMission].self, forKey: .missions)
        challenges = try container.decode([String: GamificationChallenge].self, forKey: .challenges)
        tasks = try container.decode([String: GamificationTask].self, forKey: .tasks)
        completed = try container.decode([String: Bool].self, forKey: .completed)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(gameCenterUser as? GameCenterUser, forKey: .gameCenterUser)
        try container.encode(division, forKey: .division)
        try container.encode(score, forKey: .score)
        try container.encode(coin, forKey: .coin)
        try container.encode(sequences as? [String: GamificationSequence], forKey: .sequences)
        try container.encode(missions as? [String: GamificationMission], forKey: .missions)
        try container.encode(challenges as? [String: GamificationChallenge], forKey: .challenges)
        try container.encode(tasks as? [String: GamificationTask], forKey: .tasks)
        try container.encode(completed, forKey: .completed)
    }
}
