//
//  registroViewModel.swift
//  BuddyCare
//
//  Created by Mateus Calisto on 13/06/23.
//

import Foundation
import SwiftUI

final class OnboardingModel: ObservableObject {
    private let iCloud = CloudKitService.shared
    private let localStarage = CoreDataService.shared
    
    @Published var selectedDayTimes: Int = 10
    @Published var selectedWeekTimes: Int = 1
    @Published var selectedLazyTimes: Int = 1
    @Published var selectedTimes: String = "Days"
    @Published var selectedTime = Date()
    @Published var dates: [Date] = []
    @Published var navigateToMainView = false
    @Published var buttonIsActive = true
    @Published var timeOne: Date = Date()
    @Published var timeTwo = Date.now
    @Published var timeThree = Date.now
    @Published var avatars: [String: [String]]
    
    @Published var navigateToCleaner: Bool = false
    @Published var username: String = ""
    @Published var petId = String()
    @Published var selectedSpecies: String = "cat"
    @Published var genterTypes: [String: [String]]
    
    @AppStorage("BOOL_ACCESS") var isFirstAccess = true
    
    init() {
        avatars = [
            "cat": ["OrangeCat", "BlackCat", "WhiteCat"],
            "dog": ["CaramelDog", "BlackDog", "WhiteDog"]
        ]
        genterTypes = [
            "cat": ["WhiteCat"],
            "dog": ["WhiteDog"]
        ]
    }
    
    
    let lazyTimes: [Int] = Array(1...3)
    let dayTimes: [Int] = Array(5...15)
    let times = ["Days"]
    @MainActor
    public func nextButtonHandler(with pet: Pet) async throws {
//        disableNextButton()
        try await registerNewPetAndGiveId(pet)
//        navigateToRegisterSchedulesView()
    }
    
    @MainActor
    public func startButtonHandler(for id: String) async throws {
        if buttonIsActive {
            disableStartButton()
            try localStarage.saveId(id)
            try await registerFunScheduleForThisUserPet(id: id)
            try await registerBathScheduleForThisUserPet(id: id)
            navigateToPetManagerView()
        }
    }
}

private extension OnboardingModel {
    @MainActor
    func registerNewPetAndGiveId(_ pet: Pet) async throws  {
        var pet = pet
        self.petId = try await iCloud.createPet(pet)
        pet.id = self.petId
        _ = try await localStarage.createPet(pet)
    }
    
    @MainActor
    func navigateToRegisterSchedulesView() {
        self.navigateToCleaner = true
    }
    
    @MainActor
    func disableNextButton() {
        self.buttonIsActive = false
    }
}
extension OnboardingModel {
    @MainActor
    func registerFunScheduleForThisUserPet(id: String) async throws {
        let schedule: FunSchedule = .init(
            petId: id,
            frequency: selectedDayTimes,
            times: getValidDatesFromHourPickerCounter()
        )
        
        try await iCloud.createFunSchedule(schedule)
        try await localStarage.createFunSchedule(schedule)
    }
    
    @MainActor
    func registerBathScheduleForThisUserPet(id: String) async throws {
        let schedule: BathSchedule = .init(petId: id, frequency: selectedDayTimes)
        try await iCloud.createBathSchedule(schedule)
        try await localStarage.createBathSchedule(schedule)
    }
    
    @MainActor
    func disableStartButton() {
        self.buttonIsActive = false
    }
    
    @MainActor
    func navigateToPetManagerView() {
        self.navigateToMainView = true
    }
    
    private func getValidDatesFromHourPickerCounter() -> [Date] {
        switch selectedLazyTimes {
        case 1:
            return [timeOne]
        case 2:
            return [timeOne, timeTwo]
        case 3:
            return [timeOne, timeTwo, timeThree]
        default:
            return []
        }
    }
}
