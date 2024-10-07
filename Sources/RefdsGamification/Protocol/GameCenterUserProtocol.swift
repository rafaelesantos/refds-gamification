import Foundation
import RefdsShared

public protocol GameCenterUserProtocol: RefdsModel, Sendable {
    var name: String { get }
    var alias: String { get }
    var photo: Data? { get set }
}
