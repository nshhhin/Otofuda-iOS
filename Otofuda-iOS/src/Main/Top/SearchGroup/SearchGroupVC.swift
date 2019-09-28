import UIKit
import AVFoundation

protocol SearchGroupProtocol {
    func readQRCode()
    func enterRoom(room: Room)
    func observeRooms()
}

class SearchGroupVC: UIViewController {

    @IBOutlet weak var cameraV: UIView!

    var qrV: UIView!
    
    var haveMusics: [Music] = []

    var items: [String] = []

    let captureSession = AVCaptureSession()

    var videoLayer: AVCaptureVideoPreviewLayer?

    var firebaseManager = FirebaseManager()

    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    var isMatching = false
    
    var rooms: [Room] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        observeRooms()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        print("サーチビューが起動されました")
        readQRCode()
    }
    
    deinit {
        firebaseManager.deleteAllValue(path: RoomURL.base.rawValue)
    }
}
