
import UIKit

protocol TopProtocol {
    // 関数を列挙する
    func tapCreateBtn(_ sender: Any)
    func tapSearchBtn(_ sender: Any)
}

final class TopVC: UIViewController, TopProtocol {

    // グループを作成するボタン
    @IBAction func tapCreateBtn(_ sender: Any) {
        // QRコードを生成・表示する画面に遷移
        let next =  storyboard!.instantiateViewController(withIdentifier: "CreateGroupView")
        next.modalTransitionStyle = .crossDissolve
        self.present(next,animated: true, completion: nil)
    }
    
    // グループに参加するボタン
    @IBAction func tapSearchBtn(_ sender: Any) {
        // カメラを起動してQRコードを読み取る画面に遷移
        let next =  storyboard!.instantiateViewController(withIdentifier: "SearchGroupView")
        next.modalTransitionStyle = .crossDissolve
        self.present(next,animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

