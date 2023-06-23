//
//  CloudKitService.swift
//  BuddyCare
//
//  Created by Gabriel Santiago on 12/06/23.
//

import Foundation
import CloudKit

typealias CloudKitServiceDelegate = PetUseCases & BathScheduleUseCases & FunScheduleUseCases & FunActionUseCases & BathActionUseCases

struct CloudKitService {
    let database: CKDatabase
    static let shared: CloudKitServiceDelegate = CloudKitService()

    private init(database: CKDatabase = CKContainer(identifier: "iCloud.br.com.yago.BuddyCare").privateCloudDatabase) {
        self.database = database
    }
}

extension CloudKitService: PetUseCases {    
    func createPet(_ pet: Pet) async throws -> String{
        let record = pet.record()
        try await database.save(record)
        
        return record.recordID.recordName
    }

    func updatePet(of id: String, new pet: Pet) async throws {
        let record = try await database.record(for: .init(recordName: id))
        record.setValue(pet.name, forKey: "name")
        record.setValue(pet.gender, forKey: "gender")
        record.setValue(pet.species, forKey: "species")
        record.setValue(pet.avatar, forKey: "avatar")

        try await database.save(record)
    }

    func fetchPets() async throws -> [Pet] {
        let response = try await database
            .records(
                matching: .init(recordType: "Pet", predicate: .init(value: true))
            )

        let records = response.matchResults.map { $0.1 }
        var pets = [Pet]()

        for record in records {
            if case .success(let record) = record {
                if let pet = try Pet.make(record: record) as? Pet {
                    pets.append(pet)
                }
            }
        }

        return pets
    }

    func deletePet(of id: String) async throws {
        try await database.deleteRecord(withID: .init(recordName: id))
    }
}

extension CloudKitService: BathScheduleUseCases {
    func createBathSchedule(_ schedule: BathSchedule) async throws {
        try await database.save(schedule.record())
    }

    func updateBathSchedule(of id: String, new schedule: BathSchedule) async throws {
        let record = try await database.record(for: .init(recordName: id))
        record.setValue(schedule.frequency, forKey: "frequency")

        try await database.save(record)
    }

    func fetchBathSchedules() async throws -> [BathSchedule] {
        let response = try await database
            .records(
                matching: .init(recordType: "BathSchedule", predicate: .init(value: true))
            )

        let records = response.matchResults.map { $0.1 }
        var schedules = [BathSchedule]()

        for record in records {
            if case .success(let record) = record {
                if let schedule = try BathSchedule.make(record: record) as? BathSchedule {
                    schedules.append(schedule)
                }
            }
        }

        return schedules
    }

    func deleteBathSchedule(of id: String) async throws {
        try await database.deleteRecord(withID: .init(recordName: id))
    }
}

extension CloudKitService: FunScheduleUseCases {
    func createFunSchedule(_ schedule: FunSchedule) async throws {
        try await database.save(schedule.record())
    }

    func updateFunSchedule(of id: String, new schedule: FunSchedule) async throws {
        let record = try await database.record(for: .init(recordName: id))
        record.setValue(schedule.frequency, forKey: "frequency")
        record.setValue(schedule.times, forKey: "times")

        try await database.save(record)
    }

    func fetchFunSchedules() async throws -> [FunSchedule] {
        let response = try await database
            .records(
                matching: .init(recordType: "FunSchedule", predicate: .init(value: true))
            )

        let records = response.matchResults.map { $0.1 }
        var schedules = [FunSchedule]()

        for record in records {
            if case .success(let record) = record {
                if let schedule = try FunSchedule.make(record: record) as? FunSchedule {
                    schedules.append(schedule)
                }
            }
        }

        return schedules
    }

    func deleteFunSchedule(of id: String) async throws {
        try await database.deleteRecord(withID: .init(recordName: id))
    }
}

extension CloudKitService: FunActionUseCases {
    func createFunAction(_ action: FunAction) async throws {
        try await database.save(action.record())
    }

    func fetchFunActions() async throws -> [FunAction] {
        let response = try await database
            .records(
                matching: .init(recordType: "FunAction", predicate: .init(value: true))
            )

        let records = response.matchResults.map { $0.1 }
        var actions = [FunAction]()

        for record in records {
            if case .success(let record) = record {
                if let action = try FunAction.make(record: record) as? FunAction {
                    actions.append(action)
                }
            }
        }

        return actions
    }

    func deleteFunAction(of id: String) async throws {
        try await database.deleteRecord(withID: .init(recordName: id))
    }
}

extension CloudKitService: BathActionUseCases {
    func createBathAction(_ action: BathAction) async throws -> String {
        let action = action.record()
        try await database.save(action)

        return action.recordID.recordName
    }

    func fetchBathActions() async throws -> [BathAction] {
        let response = try await database
            .records(
                matching: .init(recordType: "BathAction", predicate: .init(value: true))
            )

        let records = response.matchResults.map { $0.1 }
        var actions = [BathAction]()

        for record in records {
            if case .success(let record) = record {
                if let action = try BathAction.make(record: record) as? BathAction {
                    actions.append(action)
                }
            }
        }

        return actions
    }

    func deleteBathAction(of id: String) async throws {
        try await database.deleteRecord(withID: .init(recordName: id))
    }
}
