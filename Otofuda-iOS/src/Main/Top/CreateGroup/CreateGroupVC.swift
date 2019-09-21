import UIKit
import FirebaseDatabase

protocol CreateGropuProtocol {
    func createGroup() -> String
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! MenuVC
        nextVC.room = room
        nextVC.isHost = true
        nextVC.haveMusics = self.haveMusics
    }
    

}
