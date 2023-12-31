//
//  CoreDataService.swift
//  BuddyCare
//
//  Created by Yago Marques on 19/06/23.
//

import Foundation
import CoreData

typealias CoreDataManager = BathScheduleUseCases & FunScheduleUseCases & FunActionUseCases & BathActionUseCases & LocalPetIdUseCases & PetUseCases

struct CoreDataService {
    let persistentContainer: NSPersistentContainer

    static let shared: CoreDataManager = CoreDataService()

    private init (persistence: NSPersistentContainer = PersistenceController.shared.container) {
        self.persistentContainer = persistence
    }

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
}

extension CoreDataService: BathScheduleUseCases {
    func createBathSchedule(_ schedule: BathSchedule) async throws {
        let context = persistentContainer.viewContext

        let entity = BathScheduleEntity(context: context)

        entity.data = try schedule.toData()

        try context.save()
    }

    func updateBathSchedule(of id: String, new schedule: BathSchedule) async throws {
        let context = persistentContainer.viewContext

        guard let entityToUpdate = try findEntity(for: id) else { return }

        entityToUpdate.data = try schedule.toData()
        try context.save()
    }

    func fetchBathSchedules() async throws -> [BathSchedule] {
        let entities = try getRawEntities()

        let bathSchedules = try entities
            .compactMap { try BathSchedule.fromData($0.data ?? Data()) as? BathSchedule }

        return bathSchedules
    }

    func deleteBathSchedule(of id: String) async throws {
        let context = persistentContainer.viewContext

        guard let entityToDelete = try findEntity(for: id) else { return }

        context.delete(entityToDelete)
        try context.save()
    }

    private func getRawEntities() throws -> [BathScheduleEntity] {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<BathScheduleEntity>(entityName: "BathScheduleEntity")

        return try context.fetch(fetchRequest)
    }

    private func findEntity(for id: String) throws -> BathScheduleEntity? {
        let entities = try getRawEntities()

        guard let foundedEntity = try entities.filter({ entity in
            if
                let data = entity.data,
                let decodedEntity = try BathSchedule.fromData(data) as? BathSchedule,
                decodedEntity.id == id
            {
                return true
            } else {
                return false
            }
        }).first else {
            return nil
        }

        return foundedEntity
    }
}

extension CoreDataService: FunScheduleUseCases {
    func createFunSchedule(_ schedule: FunSchedule) async throws {
        let context = persistentContainer.viewContext

        let entity = FunScheduleEntity(context: context)

        entity.data = try schedule.toData()

        try context.save()
    }

    func updateFunSchedule(of id: String, new schedule: FunSchedule) async throws {
        let context = persistentContainer.viewContext

        guard let entityToUpdate = try findFunEntity(for: id) else { return }

        entityToUpdate.data = try schedule.toData()
        try context.save()
    }

    func fetchFunSchedules() async throws -> [FunSchedule] {
        let entities = try getRawFunEntities()

        let funSchedules = try entities
            .compactMap { try FunSchedule.fromData($0.data ?? Data()) as? FunSchedule }

        return funSchedules
    }

    func deleteFunSchedule(of id: String) async throws {
        let context = persistentContainer.viewContext

        guard let entityToDelete = try findFunEntity(for: id) else { return }

        context.delete(entityToDelete)
        try context.save()
    }

    private func findFunEntity(for id: String) throws -> FunScheduleEntity? {
        let entities = try getRawFunEntities()

        guard let foundedEntity = try entities.filter({ entity in
            if
                let data = entity.data,
                let decodedEntity = try FunSchedule.fromData(data) as? FunSchedule,
                decodedEntity.id == id
            {
                return true
            } else {
                return false
            }
        }).first else {
            return nil
        }

        return foundedEntity
    }

    private func getRawFunEntities() throws -> [FunScheduleEntity] {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<FunScheduleEntity>(entityName: "FunScheduleEntity")

        return try context.fetch(fetchRequest)
    }
}

extension CoreDataService: FunActionUseCases {
    func createFunAction(_ action: FunAction) async throws -> String {
        let context = persistentContainer.viewContext

        let entity = FunActionEntity(context: context)

        entity.data = try action.toData()

        try context.save()

        return action.id
    }

    func fetchFunActions() async throws -> [FunAction] {
        let entities = try getRawFunActionEntities()

        let funSchedules = try entities
            .compactMap { try FunAction.fromData($0.data ?? Data()) as? FunAction }

        return funSchedules
    }

    func deleteFunAction(of id: String) async throws {
        let context = persistentContainer.viewContext

        guard let entityToDelete = try findFunActionEntity(for: id) else { return }
        guard var model = try FunAction.fromData(entityToDelete.data!) as? FunAction else { return }
        model.isDone = 1
        entityToDelete.data = try model.toData()

        try context.save()
    }

    private func findFunActionEntity(for id: String) throws -> FunActionEntity? {
        let entities = try getRawFunActionEntities()

        guard let foundedEntity = try entities.filter({ entity in
            if
                let data = entity.data,
                let decodedEntity = try FunAction.fromData(data) as? FunAction,
                decodedEntity.id == id
            {
                return true
            } else {
                return false
            }
        }).first else {
            return nil
        }

        return foundedEntity
    }

    private func getRawFunActionEntities() throws -> [FunActionEntity] {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<FunActionEntity>(entityName: "FunActionEntity")

        return try context.fetch(fetchRequest)
    }
}

extension CoreDataService: BathActionUseCases {
    func createBathAction(_ action: BathAction) async throws -> String {
        let context = persistentContainer.viewContext

        let entity = BathActionEntity(context: context)

        entity.data = try action.toData()

        try context.save()

        return ""
    }

    func fetchBathActions() async throws -> [BathAction] {
        let entities = try getRawBathActionEntities()

        let funSchedules = try entities
            .compactMap { try BathAction.fromData($0.data ?? Data()) as? BathAction }

        return funSchedules
    }

    func deleteBathAction(of id: String) async throws {
        let context = persistentContainer.viewContext

        guard let entityToDelete = try findBathActionEntity(for: id) else { return }
        guard var model = try BathAction.fromData(entityToDelete.data!) as? BathAction else { return }
        model.isDone = 1
        entityToDelete.data = try model.toData()

        try context.save()
    }

    private func findBathActionEntity(for id: String) throws -> BathActionEntity? {
        let entities = try getRawBathActionEntities()

        guard let foundedEntity = try entities.filter({ entity in
            if
                let data = entity.data,
                let decodedEntity = try BathAction.fromData(data) as? BathAction,
                decodedEntity.id == id
            {
                return true
            } else {
                return false
            }
        }).first else {
            return nil
        }

        return foundedEntity
    }

    private func getRawBathActionEntities() throws -> [BathActionEntity] {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<BathActionEntity>(entityName: "BathActionEntity")

        return try context.fetch(fetchRequest)
    }
}

extension CoreDataService: LocalPetIdUseCases {
    func saveId(_ id: String) throws {
        let context = persistentContainer.viewContext

        let entity = IdEntity(context: context)

        entity.content = id

        try context.save()
    }

    func getId() throws -> String {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<IdEntity>(entityName: "IdEntity")

        if let id = try context.fetch(fetchRequest).first?.content {
            return id
        } else { return "invalid" }
    }
}


extension CoreDataService: PetUseCases {
    func createPet(_ pet: Pet) async throws -> String {
        let context = persistentContainer.viewContext

        let entity = PetEntity(context: context)

        entity.data = try pet.toData()

        try context.save()

        return pet.id
    }

    func updatePet(of id: String, new pet: Pet) async throws {
        let context = persistentContainer.viewContext

        guard let entityToUpdate = try findPetEntity(for: id) else { return }

        entityToUpdate.data = try pet.toData()
        try context.save()
    }

    func fetchPets() async throws -> [Pet] {
        let entities = try getRawPetEntities()

        let funSchedules = try entities
            .compactMap { try Pet.fromData($0.data ?? Data()) as? Pet }

        return funSchedules
    }

    func deletePet(of id: String) async throws {
        let context = persistentContainer.viewContext

        guard let entityToDelete = try findPetEntity(for: id) else { return }

        context.delete(entityToDelete)
        try context.save()
    }

    private func findPetEntity(for id: String) throws -> PetEntity? {
        let entities = try getRawPetEntities()

        guard let foundedEntity = try entities.filter({ entity in
            if
                let data = entity.data,
                let decodedEntity = try Pet.fromData(data) as? Pet,
                decodedEntity.id == id
            {
                return true
            } else {
                return false
            }
        }).first else {
            return nil
        }

        return foundedEntity
    }

    private func getRawPetEntities() throws -> [PetEntity] {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<PetEntity>(entityName: "PetEntity")

        return try context.fetch(fetchRequest)
    }
}
