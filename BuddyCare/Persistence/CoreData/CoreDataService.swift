//
//  CoreDataService.swift
//  BuddyCare
//
//  Created by Yago Marques on 19/06/23.
//

import Foundation
import CoreData
import SwiftUI

struct CoreDataService {
    let persistentContainer: NSPersistentContainer

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

    }

    func fetchBathSchedules() async throws -> [BathSchedule] {
        []
    }

    func deleteBathSchedule(of id: String) async throws {

    }
}

extension CoreDataService: FunScheduleUseCases {
    func createFunSchedule(_ schedule: FunSchedule) async throws {

    }

    func updateFunSchedule(of id: String, new schedule: FunSchedule) async throws {

    }

    func fetchFunSchedules() async throws -> [FunSchedule] {
        []
    }

    func deleteFunSchedule(of id: String) async throws {

    }
}
