//
//  ViewController.swift
//  Otofuda-iOS
//
//  Created by nonaka on 2019/05/10.
//  Copyright © 2019 nkmr-lab. All rights reserved.
//

import UIKit

class OtofudaTopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapCreateBtn(_ sender: Any) {
        // ルームを作るボタンをタップしたときの処理
        let next =  storyboard!.instantiateViewController(withIdentifier: "CreateGroupView")
        next.modalTransitionStyle = .crossDissolve
        self.present(next,animated: true, completion: nil)
    }
    
    @IBAction func tapSearchBtn(_ sender: Any) {
        // カメラ起動（QRコード読み込み）
    }
}

