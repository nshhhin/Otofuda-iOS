
import UIKit
import MediaPlayer

protocol ResultProtocol {
}

final class ResultVC: UIViewController, ResultProtocol {
    
    var room: Room!
    
    var haveMusics: [Music] = []
    
    // 再生順
    var selectedMusics: [Music] = []
    
    var player: MPMusicPlayerController!
    
    var firebaseManager = FirebaseManager()
    
    @IBOutlet weak var playedMusicTableV: UITableView! {
        didSet {
            playedMusicTableV.delegate = self
            playedMusicTableV.dataSource = self
            playedMusicTableV.register(cellType: ResultTableCell.self)
            playedMusicTableV.backgroundColor = .lightGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

