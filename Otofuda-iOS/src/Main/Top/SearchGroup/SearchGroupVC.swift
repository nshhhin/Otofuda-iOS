
import UIKit
import AVFoundation

protocol SearchGroupProtocol {
    func readQRCode()
}

class SearchGroupVC: UIViewController {
    
    var haveMusics: [Music] = []
    
    var qrView: UIView!
    @IBOutlet weak var cameraView: UIView!
    var items: [String] = []
    let captureSession = AVCaptureSession()
    var videoLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("サーチビューが起動されました")
        readQRCode()
    }
}
