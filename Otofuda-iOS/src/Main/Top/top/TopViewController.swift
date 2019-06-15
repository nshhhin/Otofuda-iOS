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

    // グループを作成するボタン
    @IBAction func tapCreateBtn(_ sender: Any) {
        // QRコードを生成して表示する画面に遷移
        let next =  storyboard!.instantiateViewController(withIdentifier: "CreateGroupView")
        next.modalTransitionStyle = .crossDissolve
        self.present(next,animated: true, completion: nil)
    }
    
    // グループに参加するボタン
    @IBAction func tapSearchBtn(_ sender: Any) {
        // カメラを起動してQRコードを読み取る画面に遷移
        let next =  storyboard!.instantiateViewController(withIdentifier: "SearchGroupView")
        next.modalTransitionStyle = .crossDissolve
        self.present(next,animated: true, completion: nil)
    }
}

