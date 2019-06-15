//
//  SearchGroupViewController.swift
//  Otofuda-iOS
//
//  Created by nonaka on 2019/05/10.
//  Copyright © 2019 nkmr-lab. All rights reserved.
//

import UIKit
import AVFoundation

class SearchGroupViewController: UIViewController {
    
    var qrView: UIView!
    @IBOutlet weak var cameraView: UIView!
    var items: [String] = []
    let captureSession = AVCaptureSession()
    var videoLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("サーチビューが起動されました")
//        readQRCode()
    }
    
}
