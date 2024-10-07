import Foundation
import RefdsShared

public protocol GamificationCenterProtocol: RefdsModel, Sendable {
    var gameCenterUser: GameCenterUserProtocol? { get set }
    var division: GamificationDivisionProtocol { get }
    var score: GamificationRewardProtocol { get set }
    var coin: GamificationRewardProtocol { get set }
    
    var sequences: [String: GamificationSequenceProtocol] { get set }
    var missions: [String: GamificationMissionProtocol] { get set }
    var challenges: [String: GamificationChallengeProtocol] { get set }
    var tasks: [String: GamificationTaskProtocol] { get set }
    var completed: [String: Bool] { get set }
}
