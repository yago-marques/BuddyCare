//
//  CloudKitPetManager.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import Foundation

struct CloudKitPetManager { }

extension CloudKitPetManager: FetchPet {
    func fetchPet() async throws -> DisplayedPet {
        .init(id: UUID().uuidString, gender: .female, species: .dog, name: "Bambina", avatar: "avatarAsset")
    }
}

extension CloudKitPetManager: BathManagement {
    func bathActionIsNeeded() async throws -> Bool {
        true
    }

    func registerBathAction(at time: Date) async throws {
        print("registerBathAction")
    }
}

extension CloudKitPetManager: FunManagement {
    func funActionIsNeeded() async throws -> Bool {
        false
    }

    func registerFunAction(at time: Date) async throws {
        print("registerFunAction")
    }
}
