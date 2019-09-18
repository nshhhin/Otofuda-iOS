
import UIKit
import MediaPlayer

extension PlayVC {
    
    func initializeVoice(){
        self.utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        self.utterance.volume = 1.0
        self.utterance.rate = 0.55
    }
    
    func initializePlayer() {
        self.player = .applicationMusicPlayer
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
        self.arrangedMusics = selectedMusics.shuffled()
        self.fudaCollectionV.reloadData()
    }
    
    func playMusic() {
        if selectedMusics.count <= currentIndex {
            return
        }
        player.setMusic(item: selectedMusics[currentIndex].item)
        player.play()
    }
}
