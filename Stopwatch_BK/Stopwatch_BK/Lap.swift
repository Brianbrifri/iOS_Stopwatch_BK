
import Foundation

public class Lap {
    private var lapTime = ""
    private var lapNumber: Int = 0
    
    init(lapTime: String, lapNumber: Int) {
        self.lapTime = lapTime
        self.lapNumber = lapNumber
    }
    
    func getLapTime() -> String {
        return lapTime
    }
    
    func getLapNumber() -> Int {
        return lapNumber
    }
    
}
