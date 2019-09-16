//
//  ViewController.swift
//  Otofuda-iOS
//
//  Created by nonaka on 2019/05/10.
//  Copyright © 2019 nkmr-lab. All rights reserved.
//

import UIKit

protocol topViewController {
    // 関数を列挙する
}

final class TopVC: UIViewController {

    // グループを作成するボタン
    @IBAction func tapCreateBtn(_ sender: Any) {
        // QRコードを生成・表示する画面に遷移
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

