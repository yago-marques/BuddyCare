//
//  BathManagement.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import Foundation

protocol BathManagement {
    func bathActionIsNeeded(id: String) async throws -> Bool
    func registerBathActionIfNeeded(id: String) async throws
    func markBathActionAsCompleted(id: String) async throws
}
