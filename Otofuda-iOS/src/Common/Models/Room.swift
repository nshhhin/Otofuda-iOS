
import Foundation
import UIKit

struct Room {
    var name: String!
    var member: [User] = []
    
    init(name: String){
        self.name = name
        self.member = []
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
        
        dict = [ "name": name, "member": userArray ]
        return dict
    }
    
    func url() -> String {
        return "rooms/" + name + "/"
    }
}
