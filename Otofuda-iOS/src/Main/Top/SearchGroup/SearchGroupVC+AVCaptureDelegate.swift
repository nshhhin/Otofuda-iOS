
import Foundation
import UIKit
import AVFoundation

extension SearchGroupVC: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        
        // 複数のメタデータを検出できる
        for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
            // QRコードのデータかどうかの確認
            
            if !isMatching {
                if metadata.type == AVMetadataObject.ObjectType.qr {
                    // 検出位置を取得
                    let barCode = videoLayer?.transformedMetadataObject(for: metadata) as! AVMetadataMachineReadableCodeObject
                    let box = CGRect(
                        x: barCode.bounds.minX,
                        y: barCode.bounds.minY,
                        width: barCode.bounds.width,
                        height: barCode.bounds.height
                    )
                    qrV!.frame = box
                    
                    if metadata.stringValue != nil {
                        // 検出データを取得
                        let strMetadata = metadata.stringValue!
                       
                        let roomID = cropURL(url: strMetadata)
                        
                        var room = Room(name: roomID)
                        firebaseManager.observeSingle(path: room.url(), completion: { snapshot in
                            if let roomDict = snapshot.value as? [String : Any] {
                                var member = roomDict["member"] as? [String] ?? []
                                member.append( self.appDelegate.uuid )
                                self.firebaseManager.post(path: room.url() + "member", value: member)
                                self.isMatching = true
                                
                                let storyboard = UIStoryboard(name: "Menu", bundle: nil)
                                let nextVC = storyboard.instantiateInitialViewController() as! MenuVC
                                nextVC.modalTransitionStyle = .crossDissolve
                                nextVC.room = room // TODO: メンバーを更新したRoomにする
                                nextVC.haveMusics = self.haveMusics
                                nextVC.isHost = false
                         
                                self.navigationController?.pushViewController(nextVC, animated: true)
                            }
                        })
                    }
                }
            }
        }
    }
    
    
}
