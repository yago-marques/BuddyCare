//
//  FunActionUseCases.swift
//  BuddyCare
//
//  Created by Yago Marques on 20/06/23.
//

import Foundation

protocol FunActionUseCases {
    func createFunAction(_ action: FunAction) async throws
    func fetchFunActions() async throws -> [FunAction]
    func deleteFunAction(of id: String) async throws
}
