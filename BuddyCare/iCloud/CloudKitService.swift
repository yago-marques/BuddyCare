//
//  CloudKitService.swift
//  BuddyCare
//
//  Created by Gabriel Santiago on 12/06/23.
//

import Foundation
import CloudKit


struct CloudKitService {
    let database: CKDatabase

    func createPet( _ pet: Pet) async throws {
        try await database.save(pet.record())
    }
}
