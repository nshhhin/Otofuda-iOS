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
    
    func initializeUI(){
        if isHost {
            startBtn.isHidden = false
        } else {
            startBtn.isHidden = true
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

    func playMusic() {
        player.setMusic(item: playingMusics[currentIndex].item)
        player.play()
    }

    func finishGame() {

        player.stop()
        player = nil

        let storyboard = UIStoryboard(name: "Result", bundle: nil)
        let nextVC = storyboard.instantiateInitialViewController() as! ResultVC
        nextVC.room = room
        nextVC.playingMusics = self.playingMusics
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
//            room.status = .play
//            self.firebaseManager.post(path: room.url() + "status", value: room.status.rawValue)
            
            firebaseManager.observe(path: room.url() + "tapped", completion: { snapshot in
                if let tapDict = snapshot.value as? Dictionary<String, Any> {
                    self.isTapped = true
                } else {
                    self.isTapped = false
                }
            })
            
            if isHost {
                playMusic()
                setupStartBtn(isEnabled: false)
            }
            playingMusic = playingMusics[currentIndex]
            
            navigationItem.title = String(currentIndex) + "曲目"
            currentIndex += 1
            firebaseManager.post(path: room.url() + "currentIndex", value: currentIndex)
        }
        count += 1
    }
    
    func removeCountdonwV(){
        countdownV.removeFromSuperview()
    }
    
    func observeRoomStatus(){
        firebaseManager.observe(path: room.url() + "status", completion: { snapshot in
            guard let status = snapshot.value as? String else {
                return
            }
            
            if status == RoomStatus.play.rawValue {
                self.displayCountdownV()
                self.fireTimer()
            }
        })
    }
    

}
