//
//  BathActionUseCases.swift
//  BuddyCare
//
//  Created by Yago Marques on 20/06/23.
//

import Foundation

protocol BathActionUseCases {
    func createBathAction(_ action: BathAction) async throws -> String
    func fetchBathActions() async throws -> [BathAction]
    func deleteBathAction(of id: String) async throws
}
