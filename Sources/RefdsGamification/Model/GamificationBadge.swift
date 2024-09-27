import Foundation
import RefdsShared
import SwiftUI

public struct GamificationBadge: GamificationBadgeProtocol {
    public var icon: RefdsIconSymbol
    public var shape: RefdsIconSymbol
    public var shapeOpacity: Double
    public var color: Color
    
    public init(
        icon: RefdsIconSymbol,
        shape: RefdsIconSymbol,
        shapeOpacity: Double,
        color: Color
    ) {
        self.icon = icon
        self.shape = shape
        self.shapeOpacity = shapeOpacity
        self.color = color
    }
}
