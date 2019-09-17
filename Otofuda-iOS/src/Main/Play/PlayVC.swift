
import UIKit
import MediaPlayer

protocol PlayProtocol {
    func tapExitBtn(_ sender: Any)
    func loadMusic()
    func selectRandomMusics()
    func arrangeMusics()
    func playMusic()
}

final class PlayVC: UIViewController, PlayProtocol {
    
    var musics: [Music] = []
    var arrangedMusics: [Music] = []
    let fudaMaxCount = 16
    
    
    var player: MPMusicPlayerController! {
        didSet {
            player = MPMusicPlayerController.systemMusicPlayer
            player.repeatMode = .none
        }
    }
    
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
        loadMusic()
        selectRandomMusics()
        arrangeMusics()
    }
    
    // グループを作成するボタン
    @IBAction func tapExitBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

