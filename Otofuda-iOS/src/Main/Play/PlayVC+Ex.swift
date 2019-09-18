
import UIKit
import MediaPlayer

extension PlayVC {
    
    func initializePlayer() {
        self.player = .systemMusicPlayer
        self.player.repeatMode = .none
    }
    
    func selectRandomMusics(){
        haveMusics.shuffle()
        
        // 曲が満たない場合は
        if haveMusics.count < fudaMaxCount {
            return
        }
        
        for i in 0..<fudaMaxCount {
            selectedMusics.append(haveMusics[i])
        }
    }
    
    func arrangeMusics() {
        self.fudaCollectionV.reloadData()
    }
    
    func playMusic() {
        if selectedMusics.count <= currentIndex {
            return
        }
        player.setMusic(item: selectedMusics[currentIndex].item)
        player.play()
        currentIndex += 1
    }
}
