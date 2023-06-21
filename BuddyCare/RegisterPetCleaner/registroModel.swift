//
//  registroViewModel.swift
//  BuddyCare
//
//  Created by Mateus Calisto on 13/06/23.
//

import Foundation
import SwiftUI

final class NumberPickerViewModel: ObservableObject {
    private let iCloud = CloudKitService.shared

    @Published var selectedDayTimes: Int = 10
    @Published var selectedWeekTimes: Int = 1
    @Published var selectedLazyTimes: Int = 1
    @Published var selectedTimes: String = "Dias"
    @Published var selectedTime = Date()
    @Published var dates: [Date] = []
    @Published var navigateToMainView = false
    @Published var buttonIsActive = true
    @Published var timeOne: Date = Date()
    @Published var timeTwo = Date.now
    @Published var timeThree = Date.now
    @AppStorage("BOOL_ACCESS") var isFirstAccess = true
    
    let lazyTimes: [Int] = Array(1...3)
    let dayTimes: [Int] = Array(5...15)
    let times = ["Dias"]

    @MainActor
    public func startButtonHandler(for id: String) async throws {
        if buttonIsActive {
            disableStartButton()
            try await registerFunScheduleForThisUserPet(id: id)
            try await registerBathScheduleForThisUserPet(id: id)
            navigateToPetManagerView()
        }
    }
}

extension NumberPickerViewModel {
    @MainActor
    func registerFunScheduleForThisUserPet(id: String) async throws {
        try await iCloud.createFunSchedule(
            .init(
                petId: id,
                frequency: selectedDayTimes,
                times: getValidDatesFromHourPickerCounter()
            )
        )
    }

    @MainActor
    func registerBathScheduleForThisUserPet(id: String) async throws {
        try await iCloud.createBathSchedule(
            .init(petId: id, frequency: selectedDayTimes)
        )
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
