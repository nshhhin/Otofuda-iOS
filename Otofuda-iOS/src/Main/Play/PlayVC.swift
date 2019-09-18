
import UIKit
import MediaPlayer

protocol PlayProtocol {
    func tapStartBtn(_ sender: Any)
    func initializeVoice()
    func initializePlayer()
    func selectRandomMusics()
    func arrangeMusics()
    func playMusic()
    func finishGame()
}

final class PlayVC: UIViewController, PlayProtocol {
    
    var room: Room!
    
    var haveMusics: [Music] = []
    
    // 再生順
    var selectedMusics: [Music] = []
    
    // 並び順
    var arrangedMusics: [Music] = []
    
    // 再生されている曲
    var playingMusic: Music!
    
    var currentIndex: Int = 0
    
    let fudaMaxCount = 16
    
    var player: MPMusicPlayerController!
    
    var firebaseManager = FirebaseManager()
    
    let speech = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: "お手つき")
    
    @IBOutlet weak var startBtn: UIButton! {
        didSet {
            setupStartBtn(isEnabled: true)
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
    }
  
    deinit {
        player.stop()
        player = nil
    }
    
    @IBAction func tapStartBtn(_ sender: Any) {
        if  currentIndex > selectedMusics.count - 1 {
            return
        }
        playMusic()
        setupStartBtn(isEnabled: false)
        playingMusic = selectedMusics[currentIndex]
        currentIndex += 1
    }
    
}

