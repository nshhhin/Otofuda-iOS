
import UIKit

extension PlayVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(with: FudaCollectionCell.self,
                                                      for: indexPath)

        selectedMusics[indexPath.row].isAnimating = true
        selectedMusics[indexPath.row].isTapped = true
        
        let music = selectedMusics[indexPath.row]
        firebaseManager.post(path: room.url(), value: ["tapped": music.dict()])
        currentIndex += 1
        
        collectionView.reloadItems(at: [indexPath])
        
    }
}
