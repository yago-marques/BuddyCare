//
//  CloudKitPetManager.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import Foundation

struct CloudKitPetManager {
    private let iCloud = CloudKitService.shared
}

extension CloudKitPetManager: FetchPet {
    func fetchPet() async throws -> DisplayedPet {
        .init(id: UUID().uuidString, gender: .female, species: .dog, name: "Bambina", avatar: "avatarAsset")
    }
}

extension CloudKitPetManager: BathManagement {
    func bathActionIsNeeded() async throws -> Bool {
        true
    }

    func registerBathAction(at time: Date) async throws {

    }
}

extension CloudKitPetManager: FunManagement {
    func funActionIsNeeded(id: String) async throws -> Bool {
        let remoteFunActions = try await iCloud.fetchFunActions()
        let neededAction = getNeededFunActions(remoteFunActions, for: id)

        return neededAction.isEmpty ? false : true
    }

    func registerFunActionIfNeeded(id: String) async throws {
        let existsValidActionForToday = try await hasValidActions(id: id)

        if !existsValidActionForToday {
            try await deleteLastFunActionsIfNeeded(id: id)
            try await registerDailyFunActions(id: id)
        }
    }

    func markFunActionAsCompleted(id: String) async throws {

    }

    private func registerDailyFunActions(id: String) async throws {
        let funSchedules = try await iCloud.fetchFunSchedules()
        guard let funcScheduleForUserPet = funSchedules.filter({ $0.petId == id }).first else { return }
        let funTimes = funcScheduleForUserPet.times

        for funTime in funTimes {
            guard let maximumDateToEnd = Date.dateWithTwoHoursAugmented(funTime) else { return }
            try await iCloud.createFunAction(.init(petId: id, isDone: 0, start: Date(), end: maximumDateToEnd))
        }
    }

    private func deleteLastFunActionsIfNeeded(id: String) async throws {
        let remoteFunActions = try await iCloud.fetchFunActions()
        let funActionsForThisUserPet = remoteFunActions.filter { $0.petId == id }

        for action in funActionsForThisUserPet {
            try await iCloud.deleteFunAction(of: action.id)
        }
    }

    private func getNeededFunActions(_ actions: [FunAction], for id: String) -> [FunAction] {
        return actions.filter { action in
            if
                action.isDone == 0,
                action.petId == id,
                Date.isBetween(start: action.start, end: action.end)
            {
                return true
            } else { return false }
        }
    }

    private func hasValidActions(id: String) async throws -> Bool {
        let remoteActions = try await iCloud.fetchFunActions()
        if remoteActions.isEmpty {
            return false
        } else {
            guard let someAction = remoteActions.first else { return false }
            return Date.isToday(someAction.start)
        }
    }
}


extension Date {
    static func make(hour: Int, minute: Int) -> Date? {
        if let date = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date()){
            return date
        } else { return nil }
    }

    static func dateWithTwoHoursAugmented(_ date: Date) -> Date? {
        let hour = Calendar.current.component(.hour, from: date)
        let minute = Calendar.current.component(.minute, from: date)

        if let newDate = self.make(hour: hour+2, minute: minute) {
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
}
