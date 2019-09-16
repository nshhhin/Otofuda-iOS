
import UIKit
import FirebaseDatabase

protocol CreateGropuProtocol {
    func generateQRCode(name: String)
}

class CreateGroupVC: UIViewController, CreateGropuProtocol {
    
    @IBOutlet weak var QRView: UIImageView!
    
    var firebaseManager = FirebaseManager()
    var roomID: String = ""
    var number: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomID = String.getRandomStringWithLength(length: 6)
        let room = Room(name: roomID)
        firebaseManager.post(path: RoomURL.base.rawValue, value: room.dict() )
        self.generateQRCode(name: self.roomID)
    }
    
    func createGroup(name: String){
        
    }
    
    func generateQRCode(name: String) {
        let qrImage = CIImage.generateQRImage(url: "https://uniotto.org/api/searchRoom.php?roomID=\(name)")
        QRView.image = UIImage(ciImage: qrImage)
    }

}


