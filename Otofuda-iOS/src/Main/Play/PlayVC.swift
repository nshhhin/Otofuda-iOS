
import UIKit

protocol PlayProtocol {
    func tapExitBtn(_ sender: Any)
}

final class TopVC: UIViewController, PlayProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // グループを作成するボタン
    @IBAction func tapExitBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

