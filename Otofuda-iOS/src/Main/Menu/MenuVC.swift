import UIKit

protocol Menurotocol {
    func tappedPickBtn(_ sender: Any)
    func prepareUI()
}

enum RulePoint: String {
    case normal  = "normal"
    case othello = "othello"
}

enum RulePlaying: String {
    case intro = "intro"
    case sabi  = "sabi"
    case random = "random"
}

final class MenuVC: UIViewController, Menurotocol {

    var firebaseManager = FirebaseManager()

    var room: Room!

    var haveMusics: [Music] = []

    var isHost: Bool = false

    @IBOutlet weak var blockV: UIView!
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
        prepareUI()
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
        firebaseManager.post(path: room.url() + "rule/point/", value: rulePoint.rawValue)
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
        firebaseManager.post(path: room.url() + "rule/playing/", value: rulePlaying.rawValue)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {
            //            var arrayDict: [Dictionary<String,Any>] = []
            //            for music in selectedMusics {
            //                arrayDict.append( music.dict() )
            //            }
            //            firebaseManager.post(path: room.url() + "selected", value: arrayDict)

            room.status = .play

            let nextVC = segue.destination as! PlayVC
            nextVC.haveMusics = self.haveMusics
            nextVC.room = room

            firebaseManager.post(path: room.url() + "status", value: room.status.rawValue)
        }
    }

    @IBAction func tapClearSelectBtn(_ sender: Any) {
        selectedMusics = []
        selectMusicTableV.reloadData()
    }
}
