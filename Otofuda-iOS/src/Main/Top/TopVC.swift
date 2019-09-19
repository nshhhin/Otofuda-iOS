
import UIKit
import MediaPlayer
import Mute

protocol TopProtocol {
    func requestAuth()
    func loadMusics()
    func saveMusicsUserDefaults()
}

final class TopVC: UIViewController, TopProtocol {
    
    var haveMusics: [Music] = []
    
    @IBOutlet var mutePopupV: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isMute = Mute.shared.isMute
        
        if isMute {
            self.view.addSubview(mutePopupV)
        }
        
        requestAuth()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func requestAuth() {
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                self.loadMusics()
            } else {
                self.loadMusics()
            }
        }
    }
    
    func loadMusics() {
        let userDefaults = UserDefaults.standard
        let songsQuery = MPMediaQuery.songs()
        if let songCount: Int = userDefaults.integer(forKey: "songCount") {
            guard let songs = songsQuery.collections else {
                return
            }
            if songs.count == songCount {
                let loadData = userDefaults.data(forKey: "musics")
                let songs = NSKeyedUnarchiver.unarchiveObject(with: loadData as! Data) as! [MPMediaItem]
                for song in songs {
                    haveMusics.append(Music(name: song.title ?? "不明", item: song))
                }
            } else {
                saveMusicsUserDefaults()
            }
        } else {
            saveMusicsUserDefaults()
        }
    }
    
    func saveMusicsUserDefaults() {
        
        // UserDefaultsの楽曲データを更新するための処理
        let userDefaults = UserDefaults.standard
        let songsQuery = MPMediaQuery.songs()
        
        // 一曲もなければリターンする
        guard let songs = songsQuery.collections else {
            return
        }
        
        userDefaults.set( songs.count, forKey: "songCount")
        
        var musics: [MPMediaItem] = []
        let albumsQuery = MPMediaQuery.albums()
        if let albums = albumsQuery.collections {
            for album in albums {
                for song in album.items {
                    musics.append(song)
                    haveMusics.append(Music(name: song.title ?? "不明", item: song))
                }
            }
        }
        
        let saveData = NSKeyedArchiver.archivedData(withRootObject: musics)
        userDefaults.set(saveData, forKey: "musics")
        userDefaults.synchronize()

     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "create":
            let nextVC = segue.destination as! CreateGroupVC
            nextVC.haveMusics = haveMusics
        case "search":
            let nextVC = segue.destination as! SearchGroupVC
            nextVC.haveMusics = haveMusics
        default:
            break
        }
    }
    
}

