//
//  NotificationsExtension.swift
//  BuddyCare
//
//  Created by Gabriel Santiago on 14/06/23.
//

import Foundation
import NotificationCenter

extension ContentView {

    // cada um cria um despertador de diversão, iterar sobre o array de horarios para criar um pra cada
    func dispatchFunNotification(hour: Int, minute: Int, identifier: String) {

        let title = "Time to play with your buddy!"
        let body = "Your pet is needing some attention"
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

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }

    func dispatchBathNotification(day: Int, month: Int, identifier: String) {

        let title = "Time for some clean up!"
        let body = "It's time for your pet's hygiene time"

        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()

        content.title = title
        content.body = body
        content.sound = .default

        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.hour = 8
        dateComponents.minute = 47


        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }

    func checkForNotificationAuthorization() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
                case .authorized:
                    self.dispatchFunNotification(hour: 8, minute: 47, identifier: "a")
                    self.dispatchBathNotification(day: 15, month: 06, identifier: "aaa")
                case.denied:
                    return
                case.notDetermined:
                    notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                        if didAllow {
                            self.dispatchFunNotification(hour: 8, minute: 47, identifier: "aaa")
                            self.dispatchBathNotification(day: 15, month: 06, identifier: "aaa")
                        }
                    }
                default:
                    return
            }
        }
    }
}
