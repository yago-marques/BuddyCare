//
//  FunScheduleUseCases.swift
//  BuddyCare
//
//  Created by Yago Marques on 20/06/23.
//

import Foundation

protocol FunScheduleUseCases {
    func createFunSchedule(_ schedule: FunSchedule) async throws
    func updateFunSchedule(of id: String, new schedule: FunSchedule) async throws
    func fetchFunSchedules() async throws -> [FunSchedule]
    func deleteFunSchedule(of id: String) async throws
}
