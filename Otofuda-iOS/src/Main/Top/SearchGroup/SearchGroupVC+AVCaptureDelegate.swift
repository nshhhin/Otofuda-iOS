import Foundation
import UIKit
import AVFoundation

extension SearchGroupVC: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        // 複数のメタデータを検出できる
        if !isMatching {
            for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
            // QRコードのデータかどうかの確認
                
                if metadata.type == AVMetadataObject.ObjectType.qr {
                    // 検出位置を取得
                    let barCode = videoLayer?.transformedMetadataObject(for: metadata) as! AVMetadataMachineReadableCodeObject
                    let box = CGRect(
                        x: barCode.bounds.minX,
                        y: barCode.bounds.minY + 250, // FIXME: 🐛このずれのせいでとりあえず250に設定している
                        width: barCode.bounds.width,
                        height: barCode.bounds.height
                    )
                    qrV!.frame = box

                    if metadata.stringValue != nil {
                        // 検出データを取得
                        let strMetadata = metadata.stringValue!

                        let roomID = cropURL(url: strMetadata)

                        room = Room(name: roomID)
                        firebaseManager.observeSingle(path: room.url(), completion: { snapshot in
                            if let roomDict = snapshot.value as? [String: Any] {
                                var member = roomDict["member"] as? [String] ?? []
                                member.append( self.appDelegate.uuid )
                                self.firebaseManager.post(path: self.room.url() + "member", value: member)
                                self.isMatching = true
                                self.goNextVC()
                            }
                        })
                    }
                }
            }
        }
    }

}
