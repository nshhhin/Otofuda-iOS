//
//  CreateGroupViewController.swift
//  Otofuda-iOS
//
//  Created by nonaka on 2019/05/10.
//  Copyright © 2019 nkmr-lab. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CreateGroupViewController: UIViewController {
    
    
    @IBOutlet weak var QRView: UIImageView!
    
    var DBRef:DatabaseReference!
    var roomID: String = ""
    var number: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DBRef = Database.database().reference()
        
        self.roomID = getRandomStringWithLength(length: 6)
        print(roomID)
        
        //self.createRoom(name: self.roomId)
        // ↑多分タイムスタンプとか名前を生成したり，部屋があるかどうか？チェックしてる？？？
        self.generateQRCode(name: self.roomID)
    }
    
    func generateQRCode(name: String) {
        // NSString から NSDataへ変換
        let qrStr = "https://uniotto.org/api/searchRoom.php?roomID=\(name)"
        let data = qrStr.data(using: String.Encoding.utf8)!
        // NSData型でデーターを用意
        // inputCorrectionLevelは、誤り訂正レベル
        let qr = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data, "inputCorrectionLevel": "M"])!

        let sizeTransform = CGAffineTransform(scaleX: 10, y: 10)
        let qrImage = qr.outputImage!.transformed(by: sizeTransform)
        QRView.image = UIImage(ciImage: qrImage)
    }


    // ランダムな文字列の生成
    func getRandomStringWithLength(length: Int) -> String {
        let alphabet = "1234567890abcdefghijklmnopqrstuvwxyz"
        let upperBound = UInt32(alphabet.count)
        return String((0..<length).map { _ -> Character in
            return alphabet[alphabet.index(alphabet.startIndex, offsetBy: Int(arc4random_uniform(upperBound)))]
        })
    }
}


