import Foundation
import RefdsShared

public protocol GameCenterUserProtocol: RefdsModel {
    var name: String { get }
    var alias: String { get }
    var photo: Data? { get }
}
