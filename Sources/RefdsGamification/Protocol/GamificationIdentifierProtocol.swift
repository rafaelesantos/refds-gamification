import Foundation
import SwiftUI
import RefdsShared

public protocol GamificationIdentifierProtocol: RefdsModel {
    var id: String { get }
    var category: GamificationCategory { get }
    var title: String? { get }
    var description: String { get }
    var badge: GamificationBadgeProtocol? { get }
}
