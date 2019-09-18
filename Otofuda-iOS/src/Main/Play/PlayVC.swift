
import UIKit
import MediaPlayer

protocol PlayProtocol {
    func tapStartBtn(_ sender: Any)
    func initializePlayer()
    func selectRandomMusics()
    func arrangeMusics()
    func playMusic()
}

final class PlayVC: UIViewController, PlayProtocol {
    
    var room: Room!
    
    var haveMusics: [Music] = []
    var selectedMusics: [Music] = []
    var currentIndex: Int = 0
    let fudaMaxCount = 16
    var player: MPMusicPlayerController!
    var firebaseManager = FirebaseManager()
    
    @IBOutlet weak var fudaCollectionV: UICollectionView! {
        didSet {
            fudaCollectionV.delegate = self
            fudaCollectionV.dataSource = self
            fudaCollectionV.register(cellType: FudaCollectionCell.self)
            fudaCollectionV.backgroundColor = .clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializePlayer()
        if selectedMusics.count == 0 {
            selectRandomMusics()
        }
        arrangeMusics()
        playMusic()
    }
    
    @IBAction func tapStartBtn(_ sender: Any) {
        playMusic()
    }
    
}

