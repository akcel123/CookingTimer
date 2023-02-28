//
//  Int+.swift
//  CookingTimer
//
//  Created by Денис Павлов on 27.02.2023.
//

import Foundation

extension Int {
    func getTimeString() -> String {
        let hour = String(format: "%02d", self / 3600)
        let min = String(format: "%02d", self / 60 % 60)
        let sec = String(format: "%02d", self % 60)
        
        return self / 3600 == 0 ? String(min) + " : " + String(sec) : String(hour) + " : " + String(min) + " : " + String(sec)
    }
    
    
}
