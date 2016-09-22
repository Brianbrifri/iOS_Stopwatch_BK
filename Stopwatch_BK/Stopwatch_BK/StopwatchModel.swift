
import Foundation

protocol ModelProtocol: class {
    func updateTimerView(currentTime: CLong, lapTime: CLong)
}


public class StopWatchModel {
    
    //MARK: initialize variables
    private var listOfLaps:[Lap] = []
    private var lapNumber: Int = 0
    //MARK: optional delegate for ModelProtocol
    weak var delegate: ModelProtocol?
    
    //MARK: Stopwatch states
    let STOPPED: Int = 0
    let RUNNING: Int = 1
    let PAUSED: Int = 2
    
    //MARK: Initialize more variables
    private var currentTime: CLong = 0
    private var lapTime: CLong = 0
    private var startCurrentTime: CLong
    private var startLapTime: CLong
    private var secondsPortion = 0
    private var millisecondsPortion = 0
    private var timer: Timer?
    var stopWatchState: Int
    
    //MARK: Init function for when model gets instantiated
    init(delegate: ModelProtocol) {
        lapNumber = 0
        listOfLaps = []
        stopWatchState = STOPPED
        self.delegate = delegate
    }
    
    //MARK: increases lap counter, adds lap to list of laps, resets lap time to 0
    private func addNewLap(currentLapTime: CLong) {
        lapNumber += 1
        let lap = Lap(lapTime: currentLapTime, lapNumber: lapNumber)
        listOfLaps.insert(lap, at: 0)
        lapTime = 0
    }
    
    //MARK: returns the list of laps
    func getListOfLaps() -> [Lap]{
        return listOfLaps
    }

    //MARK: returns the current number of laps
    func getNumberOfLaps() -> Int {
        return lapNumber
    }
    
    //MARK: reset function to get called when stopwatch gets reset
    private func reset() {
        stopWatchState = STOPPED
        listOfLaps = []
        currentTime = 0
        lapTime = 0
        lapNumber = 0
    }
    
    //MARK: either calls addNewLap or resets timer
    func lapResetButtonPressed() {
        if stopWatchState == PAUSED {
            reset()
            delegate?.updateTimerView(currentTime: currentTime, lapTime: lapTime)
        }
        else {
            addNewLap(currentLapTime: lapTime)
        }
        
    }
    
    //MARK: starts timer and puts it into a runLoop, repeating every .01 seconds, incrementing the 
    //currentTime and lapTime. Also updates the timerView by calling the delegate method every .01 seconds
    //Otherwise invalidates the timer to prevent timer from running but keeps current and lapTime
    func startStopButtonPressed() {
        if stopWatchState == STOPPED || stopWatchState == PAUSED {
            stopWatchState = RUNNING
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (Timer) in
                self.currentTime += 1
                self.lapTime += 1
                self.delegate?.updateTimerView(currentTime: self.currentTime, lapTime: self.lapTime)
            })
            RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
        }
        else {
            stopWatchState = PAUSED
            timer?.invalidate()
        }
        
    }
}
