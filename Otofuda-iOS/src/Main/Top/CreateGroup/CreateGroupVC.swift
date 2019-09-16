
import UIKit
import FirebaseDatabase

protocol CreateGropuProtocol {
    func generateQRCode(name: String)
}

class CreateGroupVC: UIViewController, CreateGropuProtocol {
    
    @IBOutlet weak var QRView: UIImageView!
    
    var firebaseManager = FirebaseManager()
    
    var number: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roomId = createGroup()
        generateQRCode(name: roomId)
    }
    
    func createGroup() -> String{
        let roomID = String.getRandomStringWithLength(length: 6)
        let room = Room(name: roomID)
        firebaseManager.post(path: RoomURL.base.rawValue, value: room.dict() )
        return roomID
    }
    
    func generateQRCode(name: String) {
        let qrImage = CIImage.generateQRImage(url: "https://uniotto.org/api/searchRoom.php?roomID=\(name)")
        QRView.image = UIImage(ciImage: qrImage)
    }

}


