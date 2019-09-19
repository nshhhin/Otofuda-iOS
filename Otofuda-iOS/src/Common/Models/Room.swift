
import Foundation
import UIKit

struct Room {
    var name: String!
    var member: [User] = []
    var rule: Dictionary<String, String> = [
        "playing": RulePlaying.intro.rawValue,
        "point"  : RulePoint.normal.rawValue
    ]
    
    init(name: String){
        self.name = name
        self.member = []
    }
    
    init(name: String, member: [User]) {
        self.name = name
        self.member = member
    }
    
    mutating func addMember(user: User){
        self.member.append(user)
    }
    
    func dict() -> Dictionary<String, Any>{
        var dict = Dictionary<String, Any>()
        var userArray: [String] = []
        
        for user in member {
            userArray.append(user.name)
        }
        
        dict = [ "name": name, "member": userArray, "rule": rule ]
        return dict
    }
    
    func url() -> String {
        return "rooms/" + name + "/"
    }
}
