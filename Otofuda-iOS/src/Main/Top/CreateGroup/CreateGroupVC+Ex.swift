
import UIKit

extension CreateGroupVC {
    
    func createGroup() -> String {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let me = User(name: appDelegate.uuid, musics: [], color: .red)
        
        let roomID = String.getRandomStringWithLength(length: 6)
        let current_date = Date.getCurrentDate()
        room = Room(name: roomID)
        room.addMember(user: me)
        firebaseManager.post(path: room.url(), value: room.dict() )
        firebaseManager.post(path: room.url() + "date", value: current_date)
        return roomID
    }
    
    func generateQRCode(name: String) {
        let qrImage = CIImage.generateQRImage(url: "https://uniotto.org/api/searchRoom.php?roomID=\(name)")
        qrView.image = UIImage(ciImage: qrImage)
    }
    
    func observeMember(){
        firebaseManager.observe(path: room.url() + "member", completion: { snapshot in
            guard let member = snapshot.value as? [String] else {
                return
            }
            
            self.member = []
            for i in 0..<member.count {
                let user = member[i]
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                let myColor = appDelegate.colors[i]
                self.member.append(User(name: user, musics: [], color: myColor))
            }
        })
    }
    
    func removeObserveMember(){
        firebaseManager.deleteObserve(path: room.url() + "member")
    }
    
}
