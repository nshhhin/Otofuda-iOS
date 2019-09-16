
import Foundation
import UIKit
import AVFoundation

extension SearchGroupVC: SearchGroupProtocol {
    
    func readQRCode(){
        
        // QRコードをマークするビュー
        qrView = UIView()
        qrView.layer.borderWidth = 4
        qrView.layer.borderColor = UIColor.red.cgColor
        qrView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.addSubview(qrView)
        
        // 入力（背面カメラ）
        let videoDevice = AVCaptureDevice.default(for: AVMediaType.video)
        let videoInput = try! AVCaptureDeviceInput.init(device: videoDevice!)
        captureSession.addInput(videoInput)
        
        // 出力（メタデータ）
        let metadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(metadataOutput)
        
        // QRコードを検出した際のデリゲート設定
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        // QRコードの認識を設定
        metadataOutput.metadataObjectTypes = [.qr]
        
        // プレビュー表示
        videoLayer = AVCaptureVideoPreviewLayer.init(session: captureSession)
        let box = CGRect(x: cameraView.bounds.minX, y: cameraView.bounds.minY , width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
        videoLayer?.frame = box
        videoLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill //短い方に合わせてアスペクト比を調整してくれる
        cameraView.layer.addSublayer(videoLayer!)
        
        // セッションの開始
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
    }
    
}
