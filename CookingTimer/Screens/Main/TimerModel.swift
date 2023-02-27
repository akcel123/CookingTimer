

import Foundation

class TimerModel {
    var name: String?
    var timeIncSeconds: Int
    var currentTime: Int = 0
    var isWorking = false
    var isPaused = true
    init(name: String? = nil, timeIncSeconds: Int) {
        self.name = name
        self.timeIncSeconds = timeIncSeconds
    }
    
    func tick() {
        if self.isWorking && !self.isPaused {
            self.currentTime += 1
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
