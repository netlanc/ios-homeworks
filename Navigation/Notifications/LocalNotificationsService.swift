//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by netlanc on 24.04.2024.
//

import Foundation
import UserNotifications

class LocalNotificationsService {
    
    let notificationIdentifier = "DailyUpdateNotification"
    
    func requestAuthorization() {
        Task{
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        }
    }
    
    func getStatusAuthorization() async -> Bool {
        let status = await UNUserNotificationCenter.current().notificationSettings().authorizationStatus
        
        return status == .authorized
    }
    
    func registeForLatestUpdatesIfPossible() {
        
        let content = UNMutableNotificationContent()
        content.title = "Внимание ! Внимание ! )"
        content.body = "Посмотрите последние обновления"
        content.sound = .default // .defaultCritical
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
//        dateComponents.minute = 27
//        dateComponents.second = 40
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelAllNotification() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    
}
