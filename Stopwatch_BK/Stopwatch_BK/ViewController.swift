
import UIKit

class ViewController: UIViewController {
    
    let STOPPED: Int = 0
    let RUNNING: Int = 1
    let PAUSED: Int = 2
    
    var currentTime = 0
    var lapTime = 0
    var secondsPortion = 0
    var millisecondsPortion = 0
    var timer = Timer()
    var stopWatchState: Int = 0
    
    @IBOutlet weak var stopWatchTimerDisplay: UILabel!
    @IBOutlet weak var stopWatchLapResetButton: UIButton!
    @IBAction func lapResetTouchUpInside(_ sender: AnyObject) {
        if stopWatchState == PAUSED {
            currentTime = 0
            self.stopWatchTimerDisplay.text = "00:00"
            self.stopWatchLapResetButton.setTitle("Lap", for: .normal)
        }
        else {
            self.lapTime = 0
        }
    }
    
    @IBOutlet weak var stopWatchStartStopButton: UIButton!
    @IBAction func Starter(_ sender: AnyObject) {
        print("Start Stop Pressed")
        if stopWatchState == STOPPED || stopWatchState == PAUSED {
            stopWatchState = RUNNING
            self.stopWatchLapResetButton.setTitle("Lap", for: .normal)
            self.stopWatchStartStopButton.setTitle("Stop", for: .normal)
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (Timer) in
                self.currentTime = self.currentTime + 1
                self.lapTime = self.lapTime + 1
                print("\(self.lapTime)")
                self.secondsPortion = self.currentTime / 100
                self.millisecondsPortion = self.currentTime % 100
                self.stopWatchTimerDisplay.text = "\(self.secondsPortion):\(self.millisecondsPortion)"
            })
        }
        else {
            self.stopWatchStartStopButton.setTitle("Start", for: .normal)
            self.stopWatchLapResetButton.setTitle("Reset", for: .normal)
            stopWatchState = PAUSED
            timer.invalidate()
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

