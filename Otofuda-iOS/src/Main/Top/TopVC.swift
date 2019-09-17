
import UIKit
import MediaPlayer

protocol TopProtocol {
    func requestAuth()
}

final class TopVC: UIViewController, TopProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuth()
    }
    
    func requestAuth() {
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                print("許可されましたあああああ")
            } else {
                print("拒否されましたあああああ")
            }
        }
    }
    
}

