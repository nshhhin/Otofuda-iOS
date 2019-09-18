
import UIKit
import MediaPlayer

extension PlayVC {
    
    func initializePlayer() {
        self.player = .applicationMusicPlayer
        self.player.repeatMode = .none
    }
    
    func selectRandomMusics(){
        haveMusics.shuffle()
        for i in 0..<fudaMaxCount {
            selectedMusics.append(haveMusics[i])
        }
    }
    
    func arrangeMusics() {
        self.fudaCollectionV.reloadData()
    }
    
    func playMusic() {
        player.setMusic(item: selectedMusics[currentIndex].item)
        player.play()
        currentIndex += 1
    }
}
