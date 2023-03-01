//
//  TimerManager.swift
//  CookingTimer
//
//  Created by Денис Павлов on 28.02.2023.
//

import Foundation

class TimerManager {
    
    static let shared = TimerManager()
    
    private let userDefaults = UserDefaults.standard
    
    private var enterBackgroundTime: Date?
    private var diffTime: Int?
    
    
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
        timer!.tolerance = 0.01
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}

// MARK: - background working

extension TimerManager {
    func enterBackground() {
        stopTimer()
        enterBackgroundTime = Date()
        userDefaults.set(enterBackgroundTime, forKey: UserDefaultsKeys.enterBackgroundTime)
    }
    
    func enterForeground() {
        startTimer()
        enterBackgroundTime = userDefaults.object(forKey: UserDefaultsKeys.enterBackgroundTime) as? Date
        guard let enterBackgroundTime = enterBackgroundTime else { return }
        let diffTime = Date().timeIntervalSince(enterBackgroundTime)
        self.diffTime = Int(diffTime)
        restoreTime()
    }
    
    private func restoreTime() {
        guard let diffTime = diffTime else { return }
        for _ in 0..<Int(diffTime * 10) {
            self.tick()
        }
    }
}
