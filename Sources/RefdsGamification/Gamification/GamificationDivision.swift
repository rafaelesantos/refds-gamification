import Foundation
import SwiftUI
import RefdsShared

public protocol GamificationDivision: GamificationIdentifier {
    var level: Int { get }
    var coin: Int { get }
    var score: Int { get }
}

public extension GamificationDivision {
    var category: GamificationCategory { .division }
}
