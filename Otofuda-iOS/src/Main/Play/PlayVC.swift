
import UIKit
import MediaPlayer

protocol PlayProtocol {
    func tapExitBtn(_ sender: Any)
    func initializePlayer()
    func loadMusic()
    func selectRandomMusics()
    func arrangeMusics()
    func playMusic()
}

final class PlayVC: UIViewController, PlayProtocol {
    
    var room: Room!
    
    var musics: [Music] = []
    var arrangedMusics: [Music] = []
    var currentIndex: Int = 0
    let fudaMaxCount = 16
    var player: MPMusicPlayerController!
    var firebaseManager = FirebaseManager()
    
    @IBOutlet weak var fudaCollectionV: UICollectionView! {
        didSet {
            fudaCollectionV.delegate = self
            fudaCollectionV.dataSource = self
            fudaCollectionV.register(cellType: FudaCollectionCell.self)
            fudaCollectionV.backgroundColor = UIColor.clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializePlayer()
        loadMusic() // TODO: ✨毎回読み込むのはうざいので, Uniottoのロードアルゴリズムを仕様
        selectRandomMusics()
        arrangeMusics()
        playMusic()
    }
    
    // グループを作成するボタン
    @IBAction func tapExitBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

