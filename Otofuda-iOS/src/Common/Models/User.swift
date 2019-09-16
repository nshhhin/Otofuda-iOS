
import Foundation

struct User {
    var name: String!
    var musics: [Music]
    
    func dict() -> Dictionary<String, Any> {
        var dict = Dictionary<String, Any>()
        dict = ["name": name, "musics": "musics"]
        return dict
    }
}
