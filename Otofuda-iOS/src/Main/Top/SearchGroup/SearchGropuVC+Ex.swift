import Foundation
import UIKit
import AVFoundation

extension SearchGroupVC: SearchGroupProtocol {

    func readQRCode() {

        // QRコードをマークするビュー
        qrV = UIView()
        qrV.layer.borderWidth = 4
        qrV.layer.borderColor = UIColor.red.cgColor
        qrV.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.addSubview(qrV)

        // 入力（背面カメラ）
        let videoDevice = AVCaptureDevice.default(for: AVMediaType.video)
        let videoInput = try! AVCaptureDeviceInput(device: videoDevice!)
        captureSession.addInput(videoInput)

        // 出力（メタデータ）
        let metadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(metadataOutput)

        // QRコードを検出した際のデリゲート設定
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        // QRコードの認識を設定
        metadataOutput.metadataObjectTypes = [.qr]

        // プレビュー表示
        videoLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        let box = CGRect(
            x: cameraV.bounds.minX,
            y: cameraV.bounds.minY,
            width:  UIScreen.main.bounds.size.width,
            height:  UIScreen.main.bounds.size.width
        )
        videoLayer?.frame = box
        videoLayer?.videoGravity = .resizeAspectFill //短い方に合わせてアスペクト比を調整してくれる
        cameraV.layer.addSublayer(videoLayer!)

        // セッションの開始
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }

    // https://uniotto.org/api/searchRoom.php?roomID=XXXXX → XXXXX にする
    func cropURL(url: String) -> String {
        let separatedURL: [String] = url.components(separatedBy: "=")
        let roomID: String = separatedURL[1]
        return roomID
    }

    func goNextVC(room: Room) {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let nextVC = storyboard.instantiateInitialViewController() as! MenuVC
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.room = room // TODO: メンバーを更新したRoomにする
        nextVC.haveMusics = self.haveMusics
        nextVC.isHost = false
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func observeRooms(){
        firebaseManager.observe(path: RoomURL.base.rawValue, completion: { snapshot in
            if let dbRooms = snapshot.value as? Dictionary<String, Any> {
                self.rooms = []
                
                for dbRoom in dbRooms.keys {
                    
                    guard let roomDict = dbRooms[dbRoom] as? Dictionary<String, Any> else {
                        continue
                    }
                    guard let roomName = roomDict["name"] as? String else {
                        continue
                    }
                    guard let member = roomDict["member"] as? [String] else {
                        continue
                    }
                    
                    var users: [User] = []
                    for user in member {
                        users.append( User(name: user, musics: [], color: .red))
                    }
                    
                    self.rooms.append(Room(name: roomName, member: users))
                    print("はいったあああああ")
                }
            }
        })
    }

}
