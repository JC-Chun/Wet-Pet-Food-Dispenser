//
//  NotificationPublisher.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 4/13/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//


import UIKit
import UserNotifications

class NotificationPublisher: NSObject {
    
    func sendLocalNotification(title: String,
                               body: String,
                               badge: Int?,
                               delayInterval: Int?) {
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        
//        var delayTimeTrigger: UNTimeIntervalNotificationTrigger?
//        
//        if let delayInterval = delayInterval {
//            delayTimeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(delayInterval), repeats: false)
//        }
        
        if let badge = badge {
            var currentBadgeCount = UIApplication.shared.applicationIconBadgeNumber
            currentBadgeCount += badge
            notificationContent.badge = NSNumber(integerLiteral: currentBadgeCount)
        }
        
        notificationContent.sound = UNNotificationSound.default
        
        UNUserNotificationCenter.current().delegate = self
        
        // Temporary request to create notification with mock data
        // REPLACE IT WITH A REAL TRIGGER FROM DATABASE
//        let nextMeal = Data.mealSchedules[0].mealList[0].dateAndTime
//
//        let currentDate = Date(timeIntervalSinceNow: 2)
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMM dd, yyyy h:mm a"
//        let formattedCurrentDate = formatter.string(from: currentDate)
//
//        if formattedCurrentDate == nextMeal {
//            let trigger = UNNotificationTrigger(repeats: false)
//            print(formattedCurrentDate)
//            let request = UNNotificationRequest(identifier: "Test", content: notificationContent, trigger: trigger)
//
//            UNUserNotificationCenter.current().add(request) { error in
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//
//            }
//        }
        let currentDate = Date(timeIntervalSinceNow: 10)
        let dateCompoents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: currentDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompoents, repeats: false)
        let request = UNNotificationRequest(identifier: "test", content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

extension NotificationPublisher: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let identifier = response.actionIdentifier
        
        switch identifier {
        case UNNotificationDismissActionIdentifier:
            print("notification dismissed")
            completionHandler()
        case UNNotificationDefaultActionIdentifier:
            print("notification clicked")
            completionHandler()
        default:
            print("default case")
            completionHandler()
        }
    }
}
