
import UIKit
import MediaPlayer

extension MenuVC: MPMediaPickerControllerDelegate {
    
    @IBAction func tappedPickBtn(_ sender: Any) {
        let picker = MPMediaPickerController()
        picker.delegate = self
        // 複数選択にする。（falseにすると、単数選択になる）
        picker.allowsPickingMultipleItems = true
        present(picker, animated: true, completion: nil)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection)  {
        
        selectedMusics = mediaItemCollection.musics()
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
