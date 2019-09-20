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
        
        // 縛り曲が追加されてたら
        // TODO: もっといい書き方あると思うので後で改修
        if selectedMusics.count > 0 {
            haveMusics = selectedMusics
            selectedMusics = []
        }
        
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
            count = 0
            
            firebaseManager.observe(path: room.url() + "tapped", completion: { snapshot in
                if let tapDict = snapshot.value as? Dictionary<String, Any> {
                    self.isTapped = true
                } else {
                    self.isTapped = false
                }
            })
            
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
