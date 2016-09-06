
import Foundation


public class StopWatchModel {
    private var listOfLaps:[Lap] = []
    private var lapNumber: Int = 0
    
    func createResetList() {
        lapNumber = 0
        listOfLaps = []
    }
    
    func addNewLap(currentLapTime: String) {
        lapNumber = lapNumber + 1
        let lap = Lap(lapTime: currentLapTime, lapNumber: lapNumber)
        listOfLaps.append(lap)
    }
    
    func getListOfLaps() -> [Lap]{
        return listOfLaps
    }
    
}
