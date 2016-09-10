
import UIKit

class ViewController: UIViewController {
    
    let STOPPED: Int = 0
    let RUNNING: Int = 1
    let PAUSED: Int = 2
    
    var currentTime: CLong = 0
    var lapTime: CLong = 0
    var secondsPortion = 0
    var millisecondsPortion = 0
    var timer = Timer()
    var stopWatchState: Int = 0
    
    @IBOutlet weak var stopWatchTimerDisplay: UILabel!
    @IBOutlet weak var stopWatchLapResetButton: UIButton!
    @IBAction func lapResetTouchUpInside(_ sender: AnyObject) {
        if stopWatchState == PAUSED {
            currentTime = 0
            lapTime = 0
            stopWatchTimerDisplay.text = "00:00:00"
            stopWatchLapResetButton.setTitle("Lap", for: .normal)
        }
        else {
            lapTime = 0
        }
    }
    
    @IBOutlet weak var stopWatchStartStopButton: UIButton!
    @IBAction func startStopTouchUpInside(_ sender: AnyObject) {
        print("Start Stop Pressed")
        if stopWatchState == STOPPED || stopWatchState == PAUSED {
            stopWatchState = RUNNING
            stopWatchLapResetButton.setTitle("Lap", for: .normal)
            stopWatchStartStopButton.setTitle("Stop", for: .normal)
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (Timer) in
                self.currentTime = self.currentTime + 1
                self.lapTime = self.lapTime + 1
                self.stopWatchTimerDisplay.text = self.convertTimeToString(self.currentTime)
            })
        }
        else {
            stopWatchStartStopButton.setTitle("Start", for: .normal)
            stopWatchLapResetButton.setTitle("Reset", for: .normal)
            stopWatchState = PAUSED
            timer.invalidate()
        }    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func convertTimeToString(_ time: CLong) -> String {
        var milliPortion = ""
        var millis = 0
        var seconds = 0
        var minutes = 0
        var secondsPortion = ""
        var minutesPortion = ""
        var resultString = ""
        
        millis = time % 100
        milliPortion = "\(millis)"
        if millis == 0 {
            milliPortion = "00"
        }
        if millis > 0 && millis < 10 {
            milliPortion = "0\(millis)"
        }
        
        seconds = time / 100 % 60
        secondsPortion = "\(seconds)"
        if seconds == 0 {
            secondsPortion = "00"
        }
        if seconds > 0 && seconds < 10 {
            secondsPortion = "0\(seconds)"
        }
        
        minutes = time / 100 / 60 % 60
        minutesPortion = "\(minutes)"
        if minutes == 0 {
            minutesPortion = "00"
        }
        if minutes > 0 && minutes < 10 {
            minutesPortion = "0\(minutes)"
        }
        
        resultString = "\(minutesPortion):\(secondsPortion):\(milliPortion)"
        print(resultString)
        
        return resultString
    }

}

