
import Foundation
import UIKit

struct Room {
    var name: String!
    var member: [User] = []
    
    init(name: String){
        self.name = name
        self.member = []
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
}
