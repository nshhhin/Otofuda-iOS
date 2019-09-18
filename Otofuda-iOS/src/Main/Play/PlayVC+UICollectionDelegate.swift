
import UIKit

extension PlayVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(with: FudaCollectionCell.self,
                                                      for: indexPath)

        guard let playingMusic = playingMusic else {
            return
        }
        
        let tappedMusic = arrangedMusics[indexPath.row]

        print(tappedMusic.name, playingMusic.name)
        // 正解
        if tappedMusic == playingMusic {
            tappedMusic.isAnimating = true
            tappedMusic.isTapped = true
            
            let music = selectedMusics[indexPath.row]
            firebaseManager.post(path: room.url(), value: ["tapped": music.dict()])
        }
        // 不正解
        else {
            speech.speak(utterance)
        }
        
        setupStartBtn(isEnabled: true)
        
        collectionView.reloadItems(at: [indexPath])
        
    }
}
