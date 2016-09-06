
import UIKit

class ViewController: UIViewController {
    
    let STOPPED: Int = 0
    let RUNNING: Int = 1
    let PAUSED: Int = 2
    
    var currentTime = 0
    var timer = Timer()
    var stopWatchState = 0
    
    @IBOutlet weak var stopWatchLapResetButton: UIButton!
    @IBAction func lapResetTouchUpInside(_ sender: AnyObject) {
        
    }
    
    @IBOutlet weak var stopWatchStartStopButton: UIButton!
    @IBAction func startStopTouchUpInside(_ sender: AnyObject) {
        if stopWatchState == STOPPED {
            timer.invalidate()
        }
    }

    @IBOutlet weak var stopWatchTimerDisplay: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

