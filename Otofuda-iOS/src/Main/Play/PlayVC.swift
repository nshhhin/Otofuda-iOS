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
        initializeVoice()
        initializePlayer()
        navigationItem.title = "0曲目"
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
        displayCountdownV()
        fireTimer()

        // TODO: できればく非同期で3秒たったら〜ってやりたいので保留
//        playMusic()
//        setupStartBtn(isEnabled: false)
//        playingMusic = selectedMusics[currentIndex]
//        navigationItem.title = String(currentIndex) + "曲目"
//        currentIndex += 1
    }
    
    func fireTimer(){
        countdownTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(self.countdown),
            userInfo: nil,
            repeats: true
        )
    }
    
    func displayCountdownV(){
        countdownLabel.text = "3"
        countdownV.frame = countdownV.frame
        countdownV.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(countdownV)
        countdownV.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        countdownV.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        countdownV.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        countdownV.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    @objc func countdown(){
        countdownLabel.text = String(3 - count)
        if count == 3 {
            self.removeCountdonwV()
            countdownTimer.invalidate()
            
            playMusic()
            setupStartBtn(isEnabled: false)
            playingMusic = selectedMusics[currentIndex]
            navigationItem.title = String(currentIndex) + "曲目"
            currentIndex += 1
        }
        count += 1
    }
    
    func removeCountdonwV(){
        countdownV.removeFromSuperview()
    }

}
