//
//  TimerManager.swift
//  CookingTimer
//
//  Created by Денис Павлов on 28.02.2023.
//

import Foundation

class TimerManager {
    
    static let shared = TimerManager()
    
    
    
    var isRunning: Bool {
        return timer != nil
    }
    
    var tick: () -> Void = {}
    
    
    private var timer: Timer?
    private init() {}
    
    func startTimer() {
        guard !isRunning else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.tick()
        }
        
        RunLoop.current.add(timer!, forMode: .common)
        timer!.tolerance = 0.1
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}
