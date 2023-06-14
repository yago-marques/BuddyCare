//
//  UseCases.swift
//  BuddyCare
//
//  Created by Yago Marques on 13/06/23.
//

import Foundation

protocol PetUseCases {
    func createPet(_ pet: Pet) async throws
    func updatePet(of id: String, new pet: Pet) async throws
    func fetchPets() async throws -> [Pet]
    func deletePet(of id: String) async throws
}

protocol BathScheduleUseCases {
    func createBathSchedule(_ schedule: BathSchedule) async throws
    func updateBathSchedule(of id: String, new schedule: BathSchedule) async throws
    func fetchBathSchedules() async throws -> [BathSchedule]
    func deleteBathSchedule(of id: String) async throws
}

protocol FunScheduleUseCases {
    func createFunSchedule(_ schedule: FunSchedule) async throws
    func updateFunSchedule(of id: String, new schedule: FunSchedule) async throws
    func fetchFunSchedules() async throws -> [FunSchedule]
    func deleteFunSchedule(of id: String) async throws
}
