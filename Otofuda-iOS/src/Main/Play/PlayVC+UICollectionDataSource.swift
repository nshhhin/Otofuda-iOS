
import UIKit

extension PlayVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: FudaCollectionCell.self,
                                                      for: indexPath)
        cell.titleLabel.text = selectedMusics[indexPath.row].name
        
        if selectedMusics[indexPath.row].isAnimating {
            cell.animate()
            selectedMusics[indexPath.row].isAnimating = false
        }
        
        if selectedMusics[indexPath.row].isTapped {
            cell.backgroundV.backgroundColor = .red
            cell.titleLabel.textColor = .white
            cell.soundTap()
        } else {
            cell.backgroundV.backgroundColor = .white
            cell.titleLabel.textColor = .black
        }
        
        return cell
    }

    
}
