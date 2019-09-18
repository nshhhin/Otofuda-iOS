
import UIKit
import FirebaseDatabase

protocol CreateGropuProtocol {
    func generateQRCode(name: String)
}

class CreateGroupVC: UIViewController, CreateGropuProtocol {
    
    
    @IBOutlet weak var qrView: UIImageView!
    
    var firebaseManager = FirebaseManager()
    
    var haveMusics: [Music] = []
    
    var room: Room!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roomId = createGroup()
        generateQRCode(name: roomId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func createGroup() -> String {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let me = User(name: appDelegate.uuid, musics: [])
        
        let roomID = String.getRandomStringWithLength(length: 6)
        room = Room(name: roomID)
        room.addMember(user: me)
        firebaseManager.post(path: room.url(), value: room.dict() )
        return roomID
    }
    
    func generateQRCode(name: String) {
        let qrImage = CIImage.generateQRImage(url: "https://uniotto.org/api/searchRoom.php?roomID=\(name)")
        qrView.image = UIImage(ciImage: qrImage)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! MenuVC
        nextVC.room = room
        nextVC.haveMusics = self.haveMusics
    }

}


