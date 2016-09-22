
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModelProtocol {
    
    //MARK: Stopwatch States
    let STOPPED: Int = 0
    let RUNNING: Int = 1
    let PAUSED: Int = 2
    
    private var model: StopWatchModel!
    
    //MARK: Initialize Outlets
    @IBOutlet weak var tableViewOfLaps: UITableView!
    @IBOutlet weak var lapTimerDisplay: UILabel!
    @IBOutlet weak var stopWatchTimerDisplay: UILabel!
    @IBOutlet weak var stopWatchLapResetButton: UIButton!
    @IBOutlet weak var stopWatchStartStopButton: UIButton!
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        model = StopWatchModel(delegate: self)
    }
    
    //MARK: set delegates on viewLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOfLaps.delegate = self
        tableViewOfLaps.dataSource = self
        model.delegate = self
        stopWatchLapResetButton.isEnabled = false
        stopWatchStartStopButton.layer.cornerRadius = 25
        stopWatchStartStopButton.layer.borderColor = UIColor.green.cgColor
        stopWatchStartStopButton.layer.borderWidth = 2.0
        stopWatchStartStopButton.clipsToBounds = true
        stopWatchLapResetButton.layer.cornerRadius = 25
        stopWatchLapResetButton.layer.borderColor = UIColor.gray.cgColor
        stopWatchLapResetButton.layer.borderWidth = 2.0
        stopWatchLapResetButton.clipsToBounds = true
    }
    
    //MARK: Function tied to lapReset Button. Calls model.lapResetButtonPressed()
    //and reloads tableview data
    //sets button title to lap and disabled if the state is paused, reverting to 
    //default start state
    @IBAction func lapResetTouchUpInside(_ sender: UIButton) {
        if model.stopWatchState == PAUSED {
            stopWatchLapResetButton.setTitle("Lap", for: .normal)
            stopWatchLapResetButton.isEnabled = false
            stopWatchLapResetButton.layer.borderColor = UIColor.gray.cgColor
            stopWatchLapResetButton.setTitleColor(UIColor.gray, for: .normal)
        }
        model.lapResetButtonPressed()
        tableViewOfLaps.reloadData()
    }
    
    //MARK: Function tied to startStop button. calls model.startStopButtonPressed()
    //sets button labels to Stop and Lap if pressed when paused, otherwise sets them to 
    //Start and Reset if pressed while running
    @IBAction func startStopTouchUpInside(_ sender: UIButton) {
        if model.stopWatchState == STOPPED || model.stopWatchState == PAUSED {
            stopWatchLapResetButton.setTitle("Lap", for: .normal)
            stopWatchStartStopButton.setTitle("Stop", for: .normal)
            stopWatchStartStopButton.setTitleColor(UIColor.red, for: .normal)
            stopWatchStartStopButton.layer.borderColor = UIColor.red.cgColor
            stopWatchLapResetButton.layer.borderColor = UIColor.gray.cgColor
            stopWatchLapResetButton.setTitleColor(UIColor.gray, for: .normal)
            stopWatchLapResetButton.isEnabled = true
        }
        else {
            stopWatchStartStopButton.setTitle("Start", for: .normal)
            stopWatchLapResetButton.setTitle("Reset", for: .normal)
            stopWatchStartStopButton.layer.borderColor = UIColor.green.cgColor
            stopWatchStartStopButton.setTitleColor(UIColor.green, for: .normal)
            stopWatchLapResetButton.layer.borderColor = UIColor.black.cgColor
            stopWatchLapResetButton.setTitleColor(UIColor.black, for: .normal)
        }
        model.startStopButtonPressed()
    }


    //MARK: implementation of required function cellForRowAt for tableView. Sets dequeueReusableCell return
    //to custom cell with a lapTime and lapNumber lable.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LapCellTableViewCell", for: indexPath) as! LapCellTableViewCell
        cell.lapTime.text = convertTimeToString(model.getListOfLaps()[indexPath.row].getLapTime())
        cell.lapNumber.text = "Lap# \(model.getListOfLaps()[indexPath.row].getLapNumber())"
        return cell
    }
    
    //MARK: returns number of laps for required function numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getNumberOfLaps()
    }
    
    //function from my protocol that updates the timerDisplays
    func updateTimerView(currentTime: CLong, lapTime: CLong) {
        stopWatchTimerDisplay.text = convertTimeToString(currentTime)
        lapTimerDisplay.text = convertTimeToString(lapTime)
    }
    
    //MARK: function that converts a long int to time format
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
        
        resultString = "\(minutesPortion):\(secondsPortion).\(milliPortion)"
        
        return resultString
    }

}

