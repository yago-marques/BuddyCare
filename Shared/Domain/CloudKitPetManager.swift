//
//  CloudKitPetManager.swift
//  BuddyCare
//
//  Created by Yago Marques on 22/06/23.
//

import Foundation

enum CloudPetManagerError: Error {
    case invalidFetch
}

struct CloudKitPetManager {
    private let iCloud: CloudKitServiceDelegate
    static let shared = CloudKitPetManager()

    private init(iCloud: CloudKitServiceDelegate = CloudKitService.shared) {
        self.iCloud = iCloud
    }
}

extension CloudKitPetManager: FetchPet {
    func fetchPet() async throws -> DisplayedPet {
        let pets = try await iCloud.fetchPets()
        guard let selectedPet = pets.first else {
            throw CloudPetManagerError.invalidFetch
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
        }
    }

    private func getNeededBathActions(id: String) async throws -> [BathAction] {
        let actions = try await getFilteredBathActions(id: id)

        return actions.filter { $0.day.isFuture() && $0.isDone == 0 }
    }

    private func createBathAction(id: String) async throws {
        guard let bathSchedule = try await iCloud.fetchFunSchedules().first else { return }
        guard let futureDate = Date.dateWithFrequencyAugmented(frequency: bathSchedule.frequency) else { return }

        let bathAction: BathAction = .init(
            petId: id,
            isDone: 0,
            day: futureDate
        )

        try await iCloud.createBathAction(bathAction)
        PetNotifications.shared.dispatchBathNotification(frequency: bathSchedule.frequency)
    }

    private func deleteBathActionsIfNeeded(id: String) async throws {
        let actions = try await getFilteredBathActions(id: id)

        for action in actions {
            try await iCloud.deleteBathAction(of: action.id)
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
        return try await iCloud.fetchBathActions().filter { $0.id == id }
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
        }
    }

    private func registerDailyFunActions(id: String) async throws {
        let funSchedules = try await getFunSchedules()
        guard let funcScheduleForUserPet = funSchedules.filter({ $0.petId == id }).first else { return }
        let funTimes = funcScheduleForUserPet.times

        for (index, funTime) in funTimes.enumerated() {
            guard let maximumDateToEnd = Date.dateWithTwoHoursAugmented(funTime) else { return }
            try await iCloud.createFunAction(.init(petId: id, isDone: 0, start: funTime, end: maximumDateToEnd))
            PetNotifications.shared.dispatchFunNotification(date: funTime, identifier: "Fun-Notification-\(index)")
        }
    }

    private func deleteLastFunActionsIfNeeded(id: String) async throws {
        let remoteFunActions = try await getFunActions()
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

    private func getFunSchedules() async throws -> [FunSchedule] {
        try await iCloud.fetchFunSchedules()
    }

    private func getFunActions() async throws -> [FunAction] {
        try await iCloud.fetchFunActions()
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

