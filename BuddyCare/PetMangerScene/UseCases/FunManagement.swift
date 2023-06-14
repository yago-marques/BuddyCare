//
//  FunManagement.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import Foundation

protocol FunManagement {
    func funActionIsNeeded() async throws -> Bool
    func registerFunAction(at time: Date) async throws
}
