import Foundation
import RefdsShared

public protocol GameCenterUser: RefdsModel {
    var name: String { get }
    var alias: String { get }
    var photo: Data? { get }
}

struct GameCenterUserModel: GameCenterUser {
    var name: String
    var alias: String
    var photo: Data?
    
    init(
        name: String,
        alias: String,
        photo: Data? = nil
    ) {
        self.name = name
        self.alias = alias
        self.photo = photo
    }
}
