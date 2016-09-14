
import Foundation

protocol ModelProtocol: class {
    func updateTimerView(currentTime: CLong, lapTime: CLong)
}


public class StopWatchModel {
    private var listOfLaps:[Lap] = []
    private var lapNumber: Int = 0
    weak var delegate: ModelProtocol?
    
    let STOPPED: Int = 0
    let RUNNING: Int = 1
    let PAUSED: Int = 2
    
    private var currentTime: CLong = 0
    private var lapTime: CLong = 0
    private var secondsPortion = 0
    private var millisecondsPortion = 0
    private var timer: Timer?
    var stopWatchState: Int
    
    init() {
        lapNumber = 0
        listOfLaps = []
        stopWatchState = STOPPED
    }
    
    private func addNewLap(currentLapTime: CLong) {
        lapNumber += 1
        let lap = Lap(lapTime: currentLapTime, lapNumber: lapNumber)
        listOfLaps.insert(lap, at: 0)
        lapTime = 0
    }
    
    func getListOfLaps() -> [Lap]{
        return listOfLaps
    }

    func getNumberOfLaps() -> Int {
        return lapNumber
    }
    
    private func reset() {
        stopWatchState = STOPPED
        listOfLaps = []
        currentTime = 0
        lapTime = 0
        lapNumber = 0
    }
    
    func lapResetButtonPressed() {
        if stopWatchState == PAUSED {
            reset()
            delegate?.updateTimerView(currentTime: currentTime, lapTime: lapTime)
        }
        else {
            addNewLap(currentLapTime: lapTime)
        }
        
    }
    
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
