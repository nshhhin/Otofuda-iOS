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
            width: cameraV.bounds.width,
            height: cameraV.bounds.height
        )
        videoLayer?.frame = box
        videoLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill //短い方に合わせてアスペクト比を調整してくれる
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

    func goNextVC() {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let nextVC = storyboard.instantiateInitialViewController() as! MenuVC
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.room = room // TODO: メンバーを更新したRoomにする
        nextVC.haveMusics = self.haveMusics
        nextVC.isHost = false
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}
