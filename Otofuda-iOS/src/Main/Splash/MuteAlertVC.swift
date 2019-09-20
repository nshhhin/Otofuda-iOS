import UIKit
import Lottie

class MuteAlertVC: UIViewController {

    var timer: Timer!
    
    var displayTime = 1.0 // TODO: 普段は3.0ぐらいにする

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

        // TODO: 🐛なぜか表示されない
        let animationV = AnimationView()
        let animation = Animation.named("mute_animation")
        animationV.contentMode = .scaleAspectFit
        muteAnimationV.addSubview(animationV)
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
