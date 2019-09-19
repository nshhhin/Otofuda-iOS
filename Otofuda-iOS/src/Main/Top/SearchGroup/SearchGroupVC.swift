
import UIKit
import AVFoundation

protocol SearchGroupProtocol {
    func readQRCode()
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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        print("サーチビューが起動されました")
        readQRCode()
    }
}
