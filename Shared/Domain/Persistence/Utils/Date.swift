//
//  Date.swift
//  BuddyCare
//
//  Created by Yago Marques on 22/06/23.
//

import Foundation

extension Date {
    static func make(hour: Int, minute: Int) -> Date? {
        if let date = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date()){
            return date
        } else { return nil }
    }

    static func make(day: Int, month: Int) -> Date? {
        let dayString = String(day)
        let formattedDay = dayString.count < 2 ? "0\(dayString)" : dayString

        let monthString = String(month)
        let formattedMonth = monthString.count < 2 ? "0\(monthString)" : monthString

        let currentYear = Calendar.current.component(.year, from: Date())
        let formattedYear = String(currentYear)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"

        let dateAugmented = formatter.date(from: "\(formattedYear)/\(formattedMonth)/\(formattedDay) 08:30")

        return dateAugmented
    }

    static func dateWithTwoHoursAugmented(_ date: Date) -> Date? {
        let hour = Calendar.current.component(.hour, from: date)
        let minute = Calendar.current.component(.minute, from: date)

        if let newDate = self.make(hour: hour+2, minute: minute) {
            return newDate
        } else { return nil }
    }

    static func dateWithFrequencyAugmented(frequency: Int) -> Date? {
        let now = Date()
        let day = Calendar.current.component(.day, from: now)
        var currentMonth = Calendar.current.component(.month, from: Date())

        var futureDay = day + frequency

        if futureDay > 30 {
            futureDay -= 30
            currentMonth += 1
        }

        if let newDate = self.make(day: futureDay, month: currentMonth) {
            return newDate
        } else { return nil }
    }

    static func isBetween(start: Date, end: Date) -> Bool {
        let hourOfStart = Calendar.current.component(.hour, from: start)
        let minuteOfStart = Calendar.current.component(.hour, from: start)
        let startHourInDoubleFormat = Double(hourOfStart) + (Double(minuteOfStart)/100)

        let hourOfEnd = Calendar.current.component(.hour, from: end)
        let minuteOfEnd = Calendar.current.component(.hour, from: end)
        let endHourInDoubleFormat = Double(hourOfEnd) + (Double(minuteOfEnd)/100)

        let currentHour = Calendar.current.component(.hour, from: Date())
        let currentMinute = Calendar.current.component(.hour, from: Date())
        let currentHourInDoubleFormat = Double(currentHour) + (Double(currentMinute)/100)

        if currentHourInDoubleFormat <= endHourInDoubleFormat, currentHourInDoubleFormat >= startHourInDoubleFormat {
            return true
        } else { return false }
    }

    static func isToday(_ date: Date) -> Bool {
        let day = Calendar.current.component(.day, from: date)
        let month = Calendar.current.component(.month, from: date)

        let currentDay = Calendar.current.component(.day, from: Date())
        let currentMonth = Calendar.current.component(.month, from: Date())

        if currentDay == day, currentMonth == month {
            return true
        } else { return false }
    }

    func isFuture() -> Bool {
        let day = Calendar.current.component(.day, from: self)
        let month = Calendar.current.component(.month, from: self)

        let currentDay = Calendar.current.component(.day, from: Date())
        let currentMonth = Calendar.current.component(.month, from: Date())

        if
            day > currentDay ||
            month > currentMonth
        {
            return true
        }

        return false
    }
}
