
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let STOPPED: Int = 0
    let RUNNING: Int = 1
    let PAUSED: Int = 2
    
    var currentTime: CLong = 0
    var lapTime: CLong = 0
    var secondsPortion = 0
    var millisecondsPortion = 0
    var timer = Timer()
    var stopWatchState: Int = 0
    
    let model = StopWatchModel()
    @IBOutlet weak var tableViewOfLaps: UITableView!
    @IBOutlet weak var lapTimerDisplay: UILabel!
    @IBOutlet weak var stopWatchTimerDisplay: UILabel!
    @IBOutlet weak var stopWatchLapResetButton: UIButton!
    @IBOutlet weak var stopWatchStartStopButton: UIButton!
    
    @IBAction func lapResetTouchUpInside(_ sender: AnyObject) {
        if stopWatchState == PAUSED {
            currentTime = 0
            lapTime = 0
            stopWatchTimerDisplay.text = "00:00:00"
            lapTimerDisplay.text = "00:00:00"
            stopWatchLapResetButton.setTitle("Lap", for: .normal)
            model.createResetList()
            tableViewOfLaps.reloadData()
            stopWatchState = STOPPED
        }
        else {
            model.addNewLap(currentLapTime: convertTimeToString(lapTime))
            tableViewOfLaps.reloadData()
            lapTime = 0
        }
    }
    
    @IBAction func startStopTouchUpInside(_ sender: AnyObject) {
        if stopWatchState == STOPPED || stopWatchState == PAUSED {
            stopWatchState = RUNNING
            stopWatchLapResetButton.setTitle("Lap", for: .normal)
            stopWatchStartStopButton.setTitle("Stop", for: .normal)
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (Timer) in
                self.currentTime = self.currentTime + 1
                self.lapTime = self.lapTime + 1
                self.stopWatchTimerDisplay.text = self.convertTimeToString(self.currentTime)
                self.lapTimerDisplay.text = self.convertTimeToString(self.lapTime)
            })
            RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
        }
        else {
            stopWatchStartStopButton.setTitle("Start", for: .normal)
            stopWatchLapResetButton.setTitle("Reset", for: .normal)
            stopWatchState = PAUSED
            timer.invalidate()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        model.createResetList()
        tableViewOfLaps.delegate = self
        tableViewOfLaps.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = model.getListOfLaps()[indexPath.row].getLapTime()
        cell.detailTextLabel?.text = "Lap \(model.getListOfLaps()[indexPath.row].getLapNumber())"
        //cell.Lap = model.getListOfLaps()[indexPath.row].getLapNumber()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getNumberOfLaps()
    }
    
    private func convertTimeToString(_ time: CLong) -> String {
        var milliPortion = ""
        var secondsPortion = ""
        var minutesPortion = ""
        var resultString = ""
        var millis = 0
        var seconds = 0
        var minutes = 0
        
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
        
        return resultString
    }

}

