//
//  NotificationManager.swift
//  CookingTimer
//
//  Created by Денис Павлов on 02.03.2023.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static private var requestId = 0
    
    
    func notificationRequest(title: String?, subtitle: String?, body: String, timeSinceNow: Int) {
        
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(timeSinceNow), repeats: false)
        let content = UNMutableNotificationContent()
        content.title = title ?? "Таймер завершил работу"
        content.subtitle = subtitle ?? ""
        content.body = body
        content.badge = 1
//        content.sound = UNNotificationSound.default
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "Trill.mp3"))
        let notificationIdentifier = "local.notifications.\(title ?? "").\(subtitle ?? "").\(body).\(String(timeSinceNow)).\(String(Self.requestId))"
        Self.requestId += 1
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: timeTrigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                // Do something with error
                print(error)
            } else {
                // Request was added successfully
            }
        }
    }
    
    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
