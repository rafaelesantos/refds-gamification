import Foundation
import RefdsShared

public struct GameCenterUser: GameCenterUserProtocol {
    public var name: String
    public var alias: String
    public var photo: Data?
    
    public init(
        name: String,
        alias: String,
        photo: Data? = nil
    ) {
        self.name = name
        self.alias = alias
        self.photo = photo
    }
}
