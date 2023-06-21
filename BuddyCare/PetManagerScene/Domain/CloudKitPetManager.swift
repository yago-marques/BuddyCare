//
//  CloudKitPetManager.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import Foundation

enum CloudKitPetManagerError: Error {
    case invalidFetch
}

struct CloudKitPetManager {
    private let iCloud = CloudKitService.shared
    private let localStorage = CoreDataService.shared
}

extension CloudKitPetManager: FetchPet {
    func fetchPet() async throws -> DisplayedPet {
        let pets = try await iCloud.fetchPets()
        let systemPetID = try localStorage.getId()
        guard let selectedPet = pets.first(where: { $0.id == systemPetID }) else {
            throw CloudKitPetManagerError.invalidFetch
        }

        return makeDisplayedPet(selectedPet)
    }

    private func makeDisplayedPet(_ pet: Pet) -> DisplayedPet {
        .init(
            id: pet.id,
            gender: pet.gender.lowercased() == "male" ? .male : .female,
            species: pet.species.lowercased() == "dog" ? .dog : .cat,
            name: pet.name,
            avatar: pet.avatar
        )
    }
}

extension CloudKitPetManager: BathManagement {
    func bathActionIsNeeded(id: String) async throws -> Bool {
        try await getNeededBathActions(id: id).isEmpty ? false : true
    }

    func registerBathActionIfNeeded(id: String) async throws {
        let hasValidBathActionsStored = try await hasValidBathActions(id: id)

        if !hasValidBathActionsStored {
            try await deleteBathActionsIfNeeded(id: id)
            try await createBathAction(id: id)
        }
    }

    func markBathActionAsCompleted(id: String) async throws {
        let actions = try await getFilteredBathActions(id: id)

        for action in actions {
            try await iCloud.deleteBathAction(of: action.id)
            try await localStorage.deleteBathAction(of: action.id)
        }
    }

    private func getNeededBathActions(id: String) async throws -> [BathAction] {
        let actions = try await getFilteredBathActions(id: id)

        return actions.filter { $0.day.isFuture() && $0.isDone == 0 }
    }

    private func createBathAction(id: String) async throws {
        guard let bathSchedule = try await getBathSchedule() else { return }
        guard let futureDate = Date.dateWithFrequencyAugmented(frequency: bathSchedule.frequency) else { return }

        let bathAction: BathAction = .init(
            petId: id,
            isDone: 0,
            day: futureDate
        )

        try await iCloud.createBathAction(bathAction)
        try await localStorage.createBathAction(bathAction)
    }

    private func deleteBathActionsIfNeeded(id: String) async throws {
        let actions = try await getFilteredBathActions(id: id)

        for action in actions {
            try await iCloud.deleteBathAction(of: action.id)
            try await localStorage.deleteBathAction(of: action.id)
        }
    }

    private func hasValidBathActions(id: String) async throws -> Bool {
        let filteredActions = try await getFilteredBathActions(id: id)

        if filteredActions.isEmpty || filteredActions.count > 1 {
            return false
        }

        guard let bathAction = filteredActions.first else { return false }

        if bathAction.day.isFuture() || Date.isToday(bathAction.day) {
            return true
        }

        return false
    }

    private func getFilteredBathActions(id: String) async throws -> [BathAction] {
        return try await getBathActions().filter { $0.id == id }
    }

    private func getBathActions() async throws -> [BathAction] {
        let bathActions = try await localStorage.fetchBathActions()

        if bathActions.isEmpty {
            return try await iCloud.fetchBathActions()
        }

        return bathActions
    }

    private func getBathSchedule() async throws -> BathSchedule? {
        let bathSchedule = try await localStorage.fetchBathSchedules()

        if bathSchedule.isEmpty {
            guard let scheduleFromRemote = try await iCloud.fetchBathSchedules().first else {
                return nil
            }

            return scheduleFromRemote
        }

        guard let scheduleFromLocal = bathSchedule.first else { return nil }

        return scheduleFromLocal
    }
}

extension CloudKitPetManager: FunManagement {
    func funActionIsNeeded(id: String) async throws -> Bool {
        let remoteFunActions = try await getFunActions()
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
        let remoteFunActions = try await getFunActions()
        let neededAction = getNeededFunActions(remoteFunActions, for: id)

        for action in neededAction {
            try await iCloud.deleteFunAction(of: action.id)
            try await localStorage.deleteFunAction(of: action.id)
        }
    }

    private func registerDailyFunActions(id: String) async throws {
        let funSchedules = try await getFunSchedules()
        guard let funcScheduleForUserPet = funSchedules.filter({ $0.petId == id }).first else { return }
        let funTimes = funcScheduleForUserPet.times

        for funTime in funTimes {
            guard let maximumDateToEnd = Date.dateWithTwoHoursAugmented(funTime) else { return }
            try await iCloud.createFunAction(.init(petId: id, isDone: 0, start: funTime, end: maximumDateToEnd))
            try await localStorage.createFunAction(.init(petId: id, isDone: 0, start: funTime, end: maximumDateToEnd))
        }
    }

    private func deleteLastFunActionsIfNeeded(id: String) async throws {
        let remoteFunActions = try await getFunActions()
        let funActionsForThisUserPet = remoteFunActions.filter { $0.petId == id }

        for action in funActionsForThisUserPet {
            try await iCloud.deleteFunAction(of: action.id)
            try await localStorage.deleteFunAction(of: action.id)
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

    private func getFunSchedules() async throws -> [FunSchedule] {
        let funSchedules = try await localStorage.fetchFunSchedules()

        if funSchedules.isEmpty {
            return try await iCloud.fetchFunSchedules()
        } else { return funSchedules }
    }

    private func getFunActions() async throws -> [FunAction] {
        let funActions = try await localStorage.fetchFunActions()

        if funActions.isEmpty {
            return try await iCloud.fetchFunActions()
        } else { return funActions }
    }

    private func hasValidActions(id: String) async throws -> Bool {
        let remoteActions = try await getFunActions()
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
        let hour = Calendar.current.component(.hour, from: self)

        let currentDay = Calendar.current.component(.day, from: Date())
        let currentMonth = Calendar.current.component(.month, from: Date())
        let currentHour = Calendar.current.component(.hour, from: Date())

        if
            day > currentDay,
            month > currentMonth,
            hour > currentHour
        {
            return true
        }

        return false
    }
}
