//
//  FunManagement.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import Foundation

protocol FunManagement {
    func funActionIsNeeded(id: String) async throws -> Bool
    func registerFunActionIfNeeded(id: String) async throws
    func markFunActionAsCompleted(id: String) async throws
}
