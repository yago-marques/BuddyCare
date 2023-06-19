//
//  FunManagement.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import Foundation

protocol FunManagement {
//    func funActionIsNeeded(id: String) async throws -> Bool
    func funActionIsNeeded() async throws -> Bool

//    func registerFunAction(at time: Date, id: String) async throws
    func registerFunAction(at time: Date) async throws
}
