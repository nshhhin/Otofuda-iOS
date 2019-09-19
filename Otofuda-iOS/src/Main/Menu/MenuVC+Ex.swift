import UIKit

extension MenuVC {
    func prepareUI() {
        if isHost {
            blockV.isHidden = true
        } else {
            blockV.isHidden = false
            observeUI()
            observeStart()
        }
    }

    func observeUI() {
        firebaseManager.observe(path: room.url() + "rule", completion: { snapshot in
            print("ここまではいった")
            if let ruleDict = snapshot.value as? Dictionary<String, String> {
                print("ここまではいった2")
                guard let pointRule = ruleDict["point"] else { return }
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

    func observeStart() {
        firebaseManager.observe(path: room.url() + "status", completion: { snapshot in
            if let status = snapshot.value as? String {
                if status == "play" {
                    self.goNextVC()
                }
            }
        })
    }

    func goNextVC() {
        let storyboard = UIStoryboard(name: "Play", bundle: nil)
        let nextVC = storyboard.instantiateInitialViewController() as! PlayVC
        nextVC.modalTransitionStyle = .crossDissolve
        nextVC.room = room
        nextVC.haveMusics = self.haveMusics
        //        nextVC.isHost = false
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
