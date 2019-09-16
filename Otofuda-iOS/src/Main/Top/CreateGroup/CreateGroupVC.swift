
import UIKit
import FirebaseDatabase

protocol CreateGropuProtocol {
    func generateQRCode(name: String)
}

class CreateGroupVC: UIViewController, CreateGropuProtocol {
    
    @IBOutlet weak var QRView: UIImageView!
    
    var DBRef:DatabaseReference!
    var roomID: String = ""
    var number: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DBRef = Database.database().reference()
        self.roomID = String.getRandomStringWithLength(length: 6)
        print(roomID)
        
        self.generateQRCode(name: self.roomID)
    }
    
    func generateQRCode(name: String) {
        let qrImage = CIImage.generateQRImage(url: "https://uniotto.org/api/searchRoom.php?roomID=\(name)")
        QRView.image = UIImage(ciImage: qrImage)
    }

}


