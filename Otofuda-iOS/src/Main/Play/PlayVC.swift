import UIKit
import MediaPlayer

protocol PlayProtocol {
    func fireTimer()
    func displayCountdownV()
    func removeCountdonwV()
    func tapStartBtn(_ sender: Any)
    func initializeUI()
    func initializeVoice()
    func initializePlayer()
    func playMusic()
    func finishGame()
}

final class PlayVC: UIViewController, PlayProtocol {
    
    var room: Room!
    
    var isHost: Bool = false

    // 再生順
    var playingMusics: [Music] = []
    // 並び順
    var arrangeMusics: [Music] = []

    // 再生されている曲
    var playingMusic: Music!

    var currentIndex: Int = 0

    let fudaMaxCount = 16

    var player: MPMusicPlayerController!

    var firebaseManager = FirebaseManager()
    
    var isTapped = false
    
    var isPlaying = false

    let speech = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: "お手つき")
    
    var countdownTimer: Timer!
    var count = 0
    
    @IBOutlet var countdownV: UIView!
    
    @IBOutlet weak var countdownLabel: UILabel!
    
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
            fudaCollectionV.backgroundColor = .white
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUI()
        initializeVoice()
        initializePlayer()
        navigationItem.title = "1曲目"
        self.fudaCollectionV.reloadData()
        
        if !isHost {
            observeRoomStatus()
        }
    }

    deinit {
        player.stop()
        player = nil
    }

    @IBAction func tapStartBtn(_ sender: Any) {
        if player.playbackState == .playing {
            player.stop()
        }
        
        if  currentIndex > playingMusics.count - 1 {
            return
        }
        
        room.status = .play
        firebaseManager.post(path: room.url() + "status", value: room.status.rawValue)
        firebaseManager.deleteAllValue(path: room.url() + "tapped")
        
        
        displayCountdownV()
        fireTimer()
        

        // TODO: できればく非同期で3秒たったら〜ってやりたいので保留
//        playMusic()
//        setupStartBtn(isEnabled: false)
//        playingMusic = selectedMusics[currentIndex]
//        navigationItem.title = String(currentIndex) + "曲目"
//        currentIndex += 1
    }
    
}
