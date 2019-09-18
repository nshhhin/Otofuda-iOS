
import UIKit

extension PlayVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: FudaCollectionCell.self,
                                                      for: indexPath)
        cell.titleLabel.text = arrangedMusics[indexPath.row].name
        
        if arrangedMusics[indexPath.row].isAnimating {
            cell.animate()
            arrangedMusics[indexPath.row].isAnimating = false
        }
        
        if arrangedMusics[indexPath.row].isTapped {
            cell.backgroundV.backgroundColor = .red
            cell.titleLabel.textColor = .white
        } else {
            cell.backgroundV.backgroundColor = .white
            cell.titleLabel.textColor = .black
        }
        
        return cell
    }

    
}
