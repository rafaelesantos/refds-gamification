import Foundation
import RefdsShared

public protocol GamificationCenter: RefdsModel {
    var gameCenterUser: GameCenterUser? { get set }
    var division: GamificationDivision { get }
    var score: GamificationReward { get set }
    var coin: GamificationReward { get set }
    
    var sequences: [String: GamificationSequence] { get set }
    var missions: [String: GamificationMission] { get set }
    var challenges: [String: GamificationChallenge] { get set }
    var tasks: [String: GamificationTask] { get set }
    var completed: [String: Bool] { get set }
}
