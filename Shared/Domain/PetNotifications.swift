//
//  NotificationsExtension.swift
//  BuddyCare
//
//  Created by Gabriel Santiago on 14/06/23.
//

import Foundation

import UserNotifications

final class PetNotifications {

    static let shared = PetNotifications()

    private init () {}

    func dispatchFunNotification(date: Date, identifier: String) {
        let title = "Time to play with your buddy!"
        let body = "Your pet is needing some attention"
        let isDaily = true

        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()

        content.title = title
        content.body = body
        content.sound = .default

        let calendar = Calendar.current

        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)

        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)

        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }

    func dispatchBathNotification(frequency: Int) {
        let title = "Time for some clean up!"
        let body = "It's time for your pet's hygiene"

        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()

        content.title = title
        content.body = body
        content.sound = .default

        let calendar = Calendar.current

        let month = calendar.component(.month, from: Date())
        let day = calendar.component(.day, from: Date())

        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)

        if month == 02 {
            if day + frequency > 28 {
                dateComponents.day = (day + frequency) - 30
                dateComponents.month = month + 1

            } else {
                dateComponents.day = day + frequency
                dateComponents.month = month
            }
        } else {
            if day + frequency > 30 {
                dateComponents.day = (day + frequency) - 30
                dateComponents.month = month + 1

            } else {
                dateComponents.day = day + frequency
                dateComponents.month = month
            }
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "Bath-Notification", content: content, trigger: trigger)

        notificationCenter.removePendingNotificationRequests(withIdentifiers: ["Bath-Notification"])
        notificationCenter.add(request)
    }

    func checkForNotificationAuthorization() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
                case .authorized:
                    return
                case.denied:
                    return
                case.notDetermined:
                    notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                        if didAllow {
                            return
                        }
                    }
                default:
                    return
            }
        }
    }
}

