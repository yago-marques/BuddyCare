//
//  PetUseCases.swift
//  BuddyCare
//
//  Created by Yago Marques on 20/06/23.
//

import Foundation

protocol PetUseCases {
    func createPet(_ pet: Pet) async throws -> String
    func updatePet(of id: String, new pet: Pet) async throws
    func fetchPets() async throws -> [Pet]
    func deletePet(of id: String) async throws
}
