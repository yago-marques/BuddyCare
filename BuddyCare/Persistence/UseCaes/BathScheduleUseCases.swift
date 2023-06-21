//
//  BathScheduleUseCases.swift
//  BuddyCare
//
//  Created by Yago Marques on 20/06/23.
//

import Foundation

protocol BathScheduleUseCases {
    func createBathSchedule(_ schedule: BathSchedule) async throws
    func updateBathSchedule(of id: String, new schedule: BathSchedule) async throws
    func fetchBathSchedules() async throws -> [BathSchedule]
    func deleteBathSchedule(of id: String) async throws
}
