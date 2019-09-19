
import UIKit

protocol Menurotocol {
    func tappedPickBtn(_ sender: Any)
}

enum RulePoint {
    case normal
    case othello
}

enum RulePlaying {
    case intro
    case sabi
    case random
}

final class MenuVC: UIViewController, Menurotocol {
    
    var firebaseManager = FirebaseManager()
    
    var room: Room!
    
    var haveMusics: [Music] = []
    
    // ルール
    var rulePoint: RulePoint = .normal
    var rulePlaying: RulePlaying = .intro
    
    // Segument
    @IBOutlet weak var pointSegument: UISegmentedControl!
    @IBOutlet weak var playingSegument: UISegmentedControl!
    
    var selectedMusics: [Music] = []
    
    @IBOutlet weak var selectMusicTableV: UITableView! {
        didSet {
            selectMusicTableV.delegate = self
            selectMusicTableV.dataSource = self
            selectMusicTableV.register(cellType: SelectMusicTableCell.self)
            selectMusicTableV.backgroundColor = .white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changedPointSeg(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            rulePoint = .normal
        case 1:
            rulePoint = .othello
        default:
            break
        }
    }
    
    @IBAction func changePlayingSeg(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
            rulePlaying = .intro
        case 1:
           rulePlaying = .sabi
        case 2:
            rulePlaying = .random
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {
//            var arrayDict: [Dictionary<String,Any>] = []
//            for music in selectedMusics {
//                arrayDict.append( music.dict() )
//            }
//            firebaseManager.post(path: room.url() + "selected", value: arrayDict)
        
            let nextVC = segue.destination as! PlayVC
            nextVC.haveMusics = self.haveMusics
            
            nextVC.room = room
        }
    }
    
    @IBAction func tapClearSelectBtn(_ sender: Any) {
        selectedMusics = []
        selectMusicTableV.reloadData()
    }
}
