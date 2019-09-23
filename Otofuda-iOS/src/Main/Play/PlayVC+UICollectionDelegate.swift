import UIKit

extension PlayVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.dequeueReusableCell(with: FudaCollectionCell.self,
                                                      for: indexPath)
        
        cell.soundTap()

        guard let playingMusic = playingMusic else {
            return
        }

        let tappedMusic = arrangeMusics[indexPath.row]

        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let me = User(name: appDelegate.uuid, musics: [], color: .red)
        
        if !isTapped {
            firebaseManager.post(path: room.url() + "tapped", value: ["user": me.dict(), "music": playingMusic.dict()])
            firebaseManager.deleteObserve(path: room.url() + "tapped")
            isTapped = false
        }

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
