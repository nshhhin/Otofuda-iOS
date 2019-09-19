import UIKit
import MediaPlayer

extension PlayVC {

    func setupStartBtn(isEnabled: Bool) {
        if isEnabled {
            startBtn.isEnabled = true
            startBtn.backgroundColor = UIColor(
                red: 51 / 255,
                green: 102 / 255,
                blue: 204 / 255, alpha: 1
            )
        } else {
            startBtn.isEnabled = false
            startBtn.backgroundColor = .darkGray
        }
    }

    func initializeVoice() {
        self.utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        self.utterance.volume = 1.0
        self.utterance.rate = 0.55
    }

    func initializePlayer() {
        self.player = .applicationMusicPlayer
        self.player.repeatMode = .none
    }

    func selectRandomMusics() {
        haveMusics.shuffle()

        // 曲が満たない場合は
        if haveMusics.count < fudaMaxCount {
            return
        }

        for i in 0..<fudaMaxCount {
            selectedMusics.append(haveMusics[i])
        }

        var dictMusics: [Dictionary<String, Any>] = []
        for music in selectedMusics {
            dictMusics.append(music.dict())
        }

        firebaseManager.post(path: room.url() + "selectedMusics", value: dictMusics)
    }

    func arrangeMusics() {
        arrangedMusics = selectedMusics.shuffled()
        for music in selectedMusics {
            print( music.name )
        }
        self.fudaCollectionV.reloadData()
    }

    func playMusic() {
        player.setMusic(item: selectedMusics[currentIndex].item)
        player.play()
    }

    func finishGame() {

        player.stop()
        player = nil

        let storyboard = UIStoryboard(name: "Result", bundle: nil)
        let nextVC = storyboard.instantiateInitialViewController() as! ResultVC
        nextVC.room = room
        nextVC.haveMusics = self.haveMusics
        nextVC.selectedMusics = self.selectedMusics
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
