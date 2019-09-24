import UIKit

extension PlayVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // もうタップしてたら何もしない
        if isTapped {
            return
        }
        
        // まだ再生中じゃなければ何もしない
        if !isPlaying {
            return
        }
        
        guard let playingMusic = playingMusic else {
            return
        }
        
        let cell = collectionView.dequeueReusableCell(with: FudaCollectionCell.self,
                                                      for: indexPath)
        cell.soundTap()

        let tappedMusic = arrangeMusics[indexPath.row]

        let me = User(name: appDelegate.uuid, musics: [], color: .red)
        
        firebaseManager.observeSingle(path: room.url() + "tapped", completion: { snapshot in
            if var tappedDict = snapshot.value as? [Dictionary<String, Any>] {
                let dict: Dictionary<String, Any> = ["user": me.dict(), "music": tappedMusic.name]
                tappedDict.append(dict)
                self.firebaseManager.post(path: self.room.url() + "tapped", value: tappedDict)
            } else {
                var tappedDict: [Dictionary<String, Any>] = []
                let dict: Dictionary<String, Any> = ["user": me.dict(), "music": tappedMusic.name]
                tappedDict.append(dict)
                self.firebaseManager.post(path: self.room.url() + "tapped", value: tappedDict)
            }
            
            // 正解
            if tappedMusic.name == playingMusic.name {
                tappedMusic.isAnimating = true
                tappedMusic.isTapped = true
                self.firebaseManager.observeSingle(path: self.room.url() + "answearUser", completion: { snapshot2 in
                    if let answearUser = snapshot2.value as? Dictionary<String, Any> {
                        // なにもしない
                        return
                    }
                    else {
                        self.firebaseManager.post(path: self.room.url() + "answearUser", value: me)
                    }
                })
            }
            // 不正解
            else {
                self.speech.speak(self.utterance)
            }
            
            self.isTapped = true
            self.isPlaying = false
        })

        setupStartBtn(isEnabled: true)

        collectionView.reloadItems(at: [indexPath])

        // 終了判定
        if currentIndex == fudaMaxCount - 1 {
            finishGame()
        }

    }
}
