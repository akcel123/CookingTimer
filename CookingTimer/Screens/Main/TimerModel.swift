

import Foundation

class TimerModel {
    var name: String?
    var endTimeInSeconds: Int
    
    var currentTime: Int {
        //print(Int(msTime))
        return Int(msTime)
        
    }
    var isWorking = false
    var isPaused = true
    private var msTime: Double = 0.0
    
    init(name: String? = nil, timeIncSeconds: Int) {
        self.name = name
        self.endTimeInSeconds = timeIncSeconds
    }
    
   
    // MARK: - public methods
    func tick() {
        if self.isWorking && !self.isPaused {
            self.msTime += 0.1
            if self.currentTime == self.endTimeInSeconds {
                self.isWorking = false
            }
        }
    }
    
    func startTimer() {
        if currentTime < endTimeInSeconds {
            isWorking = true
            isPaused = false
        }
    }
    
    func pauseTimer() {
        isPaused.toggle()
    }
    
    
    // MARK: - User Defaults
    func getPropForUserDefaults() -> (String, Double, Int) {
        return (name ?? "", msTime, endTimeInSeconds)
    }
    
    func setPropForUserDefaults(name: String, msTime: Double, endTime: Int) {
        self.name = name
        self.msTime = msTime
        self.endTimeInSeconds = endTime
    }
    
}
