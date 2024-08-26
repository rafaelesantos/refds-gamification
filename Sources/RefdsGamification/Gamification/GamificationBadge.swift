import Foundation
import RefdsShared
import SwiftUI

public protocol GamificationBadge: RefdsModel {
    var icon: RefdsIconSymbol { get }
    var shape: RefdsIconSymbol { get }
    var shapeOpacity: Double { get }
    var color: Color { get }
}
