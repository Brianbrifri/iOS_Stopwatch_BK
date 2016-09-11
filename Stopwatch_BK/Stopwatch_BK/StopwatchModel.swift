
import Foundation


public class StopWatchModel {
    private var listOfLaps:[Lap] = []
    private var lapNumber: Int = 0
    
    func createResetList() {
        lapNumber = 0
        listOfLaps = []
    }
    
    func addNewLap(currentLapTime: String) {
        print(currentLapTime)
        lapNumber = lapNumber + 1
        let lap = Lap(lapTime: currentLapTime, lapNumber: lapNumber)
        listOfLaps.insert(lap, at: 0)
    }
    
    func getListOfLaps() -> [Lap]{
        return listOfLaps
    }

    func getNumberOfLaps() -> Int {
        return lapNumber
    }
    
    func testData() {
        for i in 0 ... 9 {
            addNewLap(currentLapTime: "00:00:0\(i)")
        }
    }
    
}
