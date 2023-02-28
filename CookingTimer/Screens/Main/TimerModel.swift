

import Foundation

class TimerModel {
    var name: String?
    var timeIncSeconds: Int
    
    var currentTime: Int {
        print(Int(msTime))
        return Int(msTime)
        
    }
    var isWorking = false
    var isPaused = true
    init(name: String? = nil, timeIncSeconds: Int) {
        self.name = name
        self.timeIncSeconds = timeIncSeconds
    }
    
    private var msTime: Double = 0.0
    
    func tick() {
        if self.isWorking && !self.isPaused {
            self.msTime += 0.1
            if self.currentTime == self.timeIncSeconds {
                self.isWorking = false
            }
        }
    }
    
    func startTimer() {
        if currentTime < timeIncSeconds {
            isWorking = true
            isPaused = false
        }
    }
    
    func stopTimer() {
        isPaused.toggle()
    }
    
}
