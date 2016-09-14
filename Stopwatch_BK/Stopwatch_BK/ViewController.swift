
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModelProtocol {
    
    let STOPPED: Int = 0
    let RUNNING: Int = 1
    let PAUSED: Int = 2
    
    private let model: StopWatchModel
    
    @IBOutlet weak var tableViewOfLaps: UITableView!
    @IBOutlet weak var lapTimerDisplay: UILabel!
    @IBOutlet weak var stopWatchTimerDisplay: UILabel!
    @IBOutlet weak var stopWatchLapResetButton: UIButton!
    @IBOutlet weak var stopWatchStartStopButton: UIButton!
    
    
    required init?(coder aDecoder: NSCoder) {
        model = StopWatchModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOfLaps.delegate = self
        tableViewOfLaps.dataSource = self
        model.delegate = self
        stopWatchLapResetButton.isEnabled = false
    }
    
    @IBAction func lapResetTouchUpInside(_ sender: UIButton) {
        if model.stopWatchState == PAUSED {
            stopWatchLapResetButton.setTitle("Lap", for: .normal)
            stopWatchLapResetButton.isEnabled = false
        }
        model.lapResetButtonPressed()
        tableViewOfLaps.reloadData()
    }
    
    @IBAction func startStopTouchUpInside(_ sender: UIButton) {
        if model.stopWatchState == STOPPED || model.stopWatchState == PAUSED {
            stopWatchLapResetButton.setTitle("Lap", for: .normal)
            stopWatchStartStopButton.setTitle("Stop", for: .normal)
            stopWatchLapResetButton.isEnabled = true
        }
        else {
            stopWatchStartStopButton.setTitle("Start", for: .normal)
            stopWatchLapResetButton.setTitle("Reset", for: .normal)
        }
        model.startStopButtonPressed()
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = convertTimeToString(model.getListOfLaps()[indexPath.row].getLapTime())
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getNumberOfLaps()
    }
    
    func updateTimerView(currentTime: CLong, lapTime: CLong) {
        stopWatchTimerDisplay.text = convertTimeToString(currentTime)
        lapTimerDisplay.text = convertTimeToString(lapTime)
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

