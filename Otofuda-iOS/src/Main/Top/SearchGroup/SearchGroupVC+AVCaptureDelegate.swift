import Foundation
import UIKit
import AVFoundation

extension SearchGroupVC: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        guard let metadataObjects = metadataObjects as? [AVMetadataMachineReadableCodeObject] else {
            return
        }
        
        for metadataObj in metadataObjects {
            if metadataObj.type != AVMetadataObject.ObjectType.qr {
                continue
            }
            
            guard let metadataStr = metadataObj.stringValue else {
                continue
            }
            
            let url  = cropURL(url: metadataStr)
            let qrRoom = Room(name: url)
            
            guard let barCode = videoLayer?.transformedMetadataObject(
                for: metadataObj
            ) as? AVMetadataMachineReadableCodeObject else {
                continue
            }
            
            let box = CGRect(
                x: barCode.bounds.minX,
                y: barCode.bounds.minY + 150,
                width: barCode.bounds.width,
                height: barCode.bounds.height
            )
            
            qrV.frame = box
            
            for room in rooms {
                if room.name == qrRoom.name {
                    // マッチング!!!
                    enterRoom(room: qrRoom)
                    continue
                }
            }
            
        }
        
        
        
        
        
        
//
//            // QRコードのデータかどうかの確認
//                if metadata.type == AVMetadataObject.ObjectType.qr {
//
//                    // 検出位置を取得
//                    let barCode = videoLayer?.transformedMetadataObject(for: metadata) as! AVMetadataMachineReadableCodeObject
//                    let box = CGRect(
//                        x: barCode.bounds.minX,
//                        y: barCode.bounds.minY + 250, // FIXME: 🐛このずれのせいでとりあえず250に設定している
//                        width: barCode.bounds.width,
//                        height: barCode.bounds.height
//                    )
//                    qrV!.frame = box
//
//                    if metadata.stringValue != nil {
//                        // 検出データを取得
//                        let strMetadata = metadata.stringValue!
//
//                        let roomID = cropURL(url: strMetadata)
//
//                        room = Room(name: roomID)
//                        firebaseManager.observeSingle(path: room.url(), completion: { snapshot in
//                            if let roomDict = snapshot.value as? [String: Any] {
//                                self.enterRoom()
//                                break cameraFor
//                            }
//                        })
//                    }
//                }
//            }
//        }
    }
    
    func enterRoom(room: Room) {
        if !isMatching {
            let now = NSDate()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-M-d-H-m"
            let current_date = formatter.string(from: now as Date)
            
//            firebaseManager.post(path: room.url() + "date", value: current_date) // Roomがまだ未定義なのでエラーになる
            
            let uuid = UIDevice.current.identifierForVendor!.uuidString
            
            firebaseManager.observeSingle(path: room.url() + "member", completion: {(snapshot) in
                var isExist: Bool = false
                if let member = snapshot.value as? [String] {
                    for user in member {
                        if user == uuid {
                            isExist = isExist || true
                        }
                    }
                }
                
                if isExist {
                    self.goNextVC()
                    self.isMatching = true
                } else {
                    if var member = snapshot.value as? [String] {
                        member.append( self.appDelegate.uuid )
                        self.firebaseManager.post(path: self.room.url() + "member", value: member)
                        self.goNextVC()
                        self.isMatching = true
                        return
                    }
                }
            })
            
        }
            
            
    }
}
