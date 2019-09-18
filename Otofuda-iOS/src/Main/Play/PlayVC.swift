
import UIKit
import MediaPlayer

protocol PlayProtocol {
    func tapStartBtn(_ sender: Any)
    func initializeVoice()
    func initializePlayer()
    func selectRandomMusics()
    func arrangeMusics()
    func playMusic()
}

final class PlayVC: UIViewController, PlayProtocol {
    
    var room: Room!
    
    var haveMusics: [Music] = []
    
    // 再生順
    var selectedMusics: [Music] = []
    
    // 並び順
    var arrangedMusics: [Music] = []
    
    var currentIndex: Int = 0
    
    let fudaMaxCount = 16
    
    var player: MPMusicPlayerController!
    
    var firebaseManager = FirebaseManager()
    
    let speech = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: "お手つき")
    
    @IBOutlet weak var startBtn: UIButton! {
        didSet {
            startBtn.isEnabled = true
        }
    }
    
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
        initializeVoice()
        initializePlayer()
        if selectedMusics.count == 0 {
            selectRandomMusics()
        }
        arrangeMusics()
        playMusic()
    }
    
    @IBAction func tapStartBtn(_ sender: Any) {
        playMusic()
        currentIndex += 1 // TODO: タップされた時はカウントアップしない
        startBtn.isEnabled = false
    }
    
}

