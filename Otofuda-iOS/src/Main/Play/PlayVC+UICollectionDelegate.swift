
import UIKit

extension PlayVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(with: FudaCollectionCell.self,
                                                      for: indexPath)

        let tappedMusic = arrangedMusics[indexPath.row]
        let playingMusic = selectedMusics[currentIndex]
       
        // 正解
        if tappedMusic == playingMusic {
            tappedMusic.isAnimating = true
            tappedMusic.isTapped = true
            
            let music = selectedMusics[indexPath.row]
            firebaseManager.post(path: room.url(), value: ["tapped": music.dict()])
            currentIndex += 1
        }
        // 不正解
        else {
            speech.speak(utterance)
            currentIndex += 1
        }
        
        startBtn.isEnabled = true
        
        collectionView.reloadItems(at: [indexPath])
        
    }
}
