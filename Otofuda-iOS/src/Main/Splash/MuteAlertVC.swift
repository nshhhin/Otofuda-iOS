import UIKit
import Lottie

class MuteAlertVC: UIViewController {

    var timer: Timer!
    
    var displayTime = 3.0 // TODO: 普段は3.0ぐらいにする

    @IBOutlet weak var muteAnimationV: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        timer = Timer.scheduledTimer(
            timeInterval: displayTime,
            target: self,
            selector: #selector(self.goNextVC),
            userInfo: nil,
            repeats: false
        )

        // FIXME: 🐛なぜか表示されない
        let animationV = AnimationView(name: "mute_animation")
//        animationV.contentMode = .scaleAspectFit
        animationV.frame = CGRect(x: animationV.frame.minX, y: animationV.frame.minY, width: 200, height: 200)
//        animationV.center = muteAnimationV.center
        muteAnimationV.addSubview(animationV)
        
        animationV.centerXAnchor.constraint(equalTo: muteAnimationV.centerXAnchor).isActive = true
        animationV.centerYAnchor.constraint(equalTo: muteAnimationV.centerYAnchor).isActive = true
        animationV.widthAnchor.constraint(equalTo: muteAnimationV.widthAnchor, multiplier: 1.0).isActive = true
        animationV.heightAnchor.constraint(equalTo: muteAnimationV.heightAnchor, multiplier: 1.0).isActive = true
        
        
        animationV.animationSpeed = 1
        animationV.loopMode = .loop
        animationV.play()
    }

    @objc func goNextVC() {
        let storyboard = UIStoryboard(name: "Top", bundle: nil)
        let nextVC = storyboard.instantiateInitialViewController()
        nextVC!.modalTransitionStyle = .crossDissolve
        present(nextVC!, animated: true, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let workingTimer = timer {
            workingTimer.invalidate()
        }
    }
}
