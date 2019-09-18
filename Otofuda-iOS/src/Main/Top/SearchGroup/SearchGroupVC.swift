
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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("サーチビューが起動されました")
        readQRCode()
    }
}
