
import UIKit

extension PlayVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(with: FudaCollectionCell.self,
                                                      for: indexPath)
        let music = arrangedMusics[indexPath.row]
        cell.animate()
        firebaseManager.post(path: room.url(), value: ["tapped": music.dict()])
        currentIndex += 1
        
    }
}
