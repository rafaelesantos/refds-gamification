import Foundation
import RefdsShared

public protocol GameCenterIdentifierProtocol {
    var icon: RefdsIconSymbol { get }
    var title: String { get }
    var description: String { get }
    var rawValue: String { get set }
}
