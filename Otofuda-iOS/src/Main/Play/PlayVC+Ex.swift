
import UIKit
import MediaPlayer

extension PlayVC {
    func loadMusic() {
        
        let albumsQuery = MPMediaQuery.albums()
        if let albums = albumsQuery.collections {
            for album in albums {
                for song in album.items {
                    guard let artist = song.value(forProperty: MPMediaItemPropertyArtist) else {
                        continue
                    }
                    guard let title = song.value(forProperty: MPMediaItemPropertyTitle) else {
                        continue
                    }
                    guard let genre = song.value(forProperty: MPMediaItemPropertyGenre) else {
                        continue
                    }
                    guard let artwork = song.value(forProperty: MPMediaItemPropertyArtwork) as? MPMediaItemArtwork else {
                        continue
                    }
                    print("artist: \(artist)")
                    print("title: \(title)")
                    print("title: \(genre)")
                    print("=======")
                    let music = Music(name: title as! String, item: song)
                    self.musics.append(music)
                }
            }
        }
    }
    
    func selectRandomMusics(){
        musics.shuffle()
        for i in 0..<fudaMaxCount {
            arrangedMusics.append(musics[i])
        }
    }
    
    func arrangeMusics() {
        self.fudaCollectionV.reloadData()
    }
    
    func playMusic() {
    }
}
