
import Foundation

//MARK: Lap class gets created for every lap. Holds lapTime and lapNumber
public class Lap {
    private var lapTime: CLong
    private var lapNumber: Int
    
    init(lapTime: CLong, lapNumber: Int) {
        self.lapTime = lapTime
        self.lapNumber = lapNumber
    }
    
    func getLapTime() -> CLong {
        return lapTime
    }
    
    func getLapNumber() -> Int {
        return lapNumber
    }
    
}
