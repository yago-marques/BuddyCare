//
//  NotificationsExtension.swift
//  BuddyCare
//
//  Created by Gabriel Santiago on 14/06/23.
//

import Foundation
import NotificationCenter

extension ContentView {

    func dispatchNotification() {

        let identifier = "MyBathIdentifier"
        let title = "Time to feed your pet!"
        let body = "min deeeee papai"
        let hour = 10
        let minute = 24
        let isDaily = true

        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()

        content.title = title
        content.body = body
        content.sound = .default

        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)

    }

    func checkForNotificationAuthorization() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
                case .authorized:
                    self.dispatchNotification()
                case.denied:
                    return
                case.notDetermined:
                    notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                        if didAllow {
                            self.dispatchNotification()
                        }
                    }
                default:
                    return
            }
        }
    }
}
