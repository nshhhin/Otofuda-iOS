import UIKit

extension PlayVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // もうタップしてたら何もしない
        if isTapped {
            return
        }
        
        let cell = collectionView.dequeueReusableCell(with: FudaCollectionCell.self,
                                                      for: indexPath)
        
        cell.soundTap()

        guard let playingMusic = playingMusic else {
            return
        }

        let tappedMusic = arrangeMusics[indexPath.row]

        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
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
            
            self.isTapped = true
        })
        
//
//        if !isTapped {
//            firebaseManager.post(path: room.url() + "tapped", value: ["user": me.dict(), "music": playingMusic.dict()])
//            firebaseManager.deleteObserve(path: room.url() + "tapped")
//            isTapped = false
//        }

        // 正解
        if tappedMusic == playingMusic {
            tappedMusic.isAnimating = true
            tappedMusic.isTapped = true
        }
            // 不正解
        else {
            speech.speak(utterance)
        }

        setupStartBtn(isEnabled: true)

        collectionView.reloadItems(at: [indexPath])

        // 終了判定
        if currentIndex == fudaMaxCount - 1 {
            finishGame()
        }

    }
}
