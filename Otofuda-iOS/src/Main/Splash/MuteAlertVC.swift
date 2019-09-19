
import UIKit

class MuteAlertVC: UIViewController {
    
    var timer: Timer!
    
    @IBOutlet weak var muteAnimationV: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timer = Timer.scheduledTimer(
            timeInterval: 3.0,
            target: self,
            selector: #selector(self.goNextVC),
            userInfo: nil,
            repeats: false
        )
        
//        let animationView = LOTAnimationView(frame: CGRect(x: 0, y: 100, width: 300, height: 300))
//        animationView.setAnimation(named: "mute_animation")
//        animationView.loopAnimation = true
//        animationView.animationSpeed = 2
//        muteAnimationV.addSubview(animationView)
//        animationView.play()
    }
    
    @objc func goNextVC() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Top", bundle: nil)
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
