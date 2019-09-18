
import UIKit

extension PlayVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(with: FudaCollectionCell.self,
                                                      for: indexPath)
        cell.animate()
        
        arrangedMusics[indexPath.row].isAnimating = true
        arrangedMusics[indexPath.row].isTapped = true
        
        let music = arrangedMusics[indexPath.row]
        firebaseManager.post(path: room.url(), value: ["tapped": music.dict()])
        currentIndex += 1
        
        collectionView.reloadItems(at: [indexPath])
        
    }
}
