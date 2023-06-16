//
//  NotificationsExtension.swift
//  BuddyCare
//
//  Created by Gabriel Santiago on 14/06/23.
//

import Foundation

#if(canImport(Notification))
import NotificationCenter
#endif

extension ContentView {

    func dispatchFunNotification(date: Date, identifier: String) {
        #if(canImport(Notification))


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
        #endif
    }

    func dispatchBathNotification(date: Date, identifier: String) {
        #if(canImport(Notification))
        let title = "Time for some clean up!"
        let body = "It's time for your pet's hygiene"

        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()

        content.title = title
        content.body = body
        content.sound = .default

        let calendar = Calendar.current

        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)

        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.hour = 8

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
        #endif

    }

    func checkForNotificationAuthorization() {
        #if(canImport(Notification))
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
        #endif
    }
}

