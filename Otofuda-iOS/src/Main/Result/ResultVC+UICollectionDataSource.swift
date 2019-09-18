
import UIKit

extension ResultVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedMusics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let music = selectedMusics[indexPath.row]
        let cell = playedMusicTableV.dequeueReusableCell(
            with: ResultTableCell.self,
            for: indexPath
        )
        cell.prepareLabel(index: indexPath.row, music: music)
        
        return cell
    }
}
