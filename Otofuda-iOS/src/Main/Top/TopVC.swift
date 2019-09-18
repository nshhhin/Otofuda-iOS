
import UIKit
import MediaPlayer

protocol TopProtocol {
    func requestAuth()
    func loadMusics()
    func saveMusicsUserDefaults()
}

final class TopVC: UIViewController, TopProtocol {
    
    var haveMusics: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuth()
    }
    
    func requestAuth() {
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
//                self.loadMusics()
                self.saveMusicsUserDefaults()
            } else {
//                self.loadMusics()
                self.saveMusicsUserDefaults()
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
                haveMusics = userDefaults.array(forKey: "musics") as! [Music]
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
        
        // data型に変換
        userDefaults.set( songs.count, forKey: "songCount")
        
        let albumsQuery = MPMediaQuery.albums()
        if let albums = albumsQuery.collections {
            for album in albums {
                for song in album.items {
                    let music = Music(name: song.title ?? "不明なタイトル", item: song)
                    haveMusics.append(music)
                }
            }
        }
        
        let saveData = try? NSKeyedArchiver.archivedData(withRootObject: haveMusics, requiringSecureCoding: false)
        userDefaults.set(saveData, forKey: "musics")
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

