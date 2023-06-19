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
        true
    }

    func registerFunAction(at time: Date, id: String) async throws {

    }

    func funActionIsNeeded() async throws -> Bool {
        false
    }

    func registerFunAction(at time: Date) async throws {
        print("registerFunAction")
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
}
