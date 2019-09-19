
import UIKit

extension MenuVC {
    func prepareUI(){
        if isHost {
            blockV.isHidden = true
        } else {
            blockV.isHidden = false
            observeUI()
        }
    }
    
    func observeUI(){
        firebaseManager.observe(path: room.url() + "rule", completion: { snapshot in
            print("ここまではいった")
            if let ruleDict = snapshot.value as? Dictionary<String, String> {
                print("ここまではいった2")
                guard let pointRule   = ruleDict["point"] else { return }
                guard let playingRule = ruleDict["playing"] else { return }
                print("ここまではいった3")
                
                switch pointRule {
                case "normal":
                    self.pointSegument.selectedSegmentIndex = 0
                case "othello":
                    self.pointSegument.selectedSegmentIndex = 1
                default:
                    break
                }
                
                switch playingRule {
                case "intro":
                    self.playingSegument.selectedSegmentIndex = 0
                case "sabi":
                    self.playingSegument.selectedSegmentIndex = 1
                case "random":
                    self.playingSegument.selectedSegmentIndex = 2
                default:
                    break
                }
            }
        })
    }
}
