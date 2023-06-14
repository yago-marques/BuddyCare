//
//  BathManagement.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import Foundation

protocol BathManagement {
    func bathActionIsNeeded() async throws -> Bool
    func registerBathAction(at time: Date) async throws
}
