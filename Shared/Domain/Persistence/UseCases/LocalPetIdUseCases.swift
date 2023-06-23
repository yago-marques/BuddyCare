//
//  SaveLocalId.swift
//  BuddyCare
//
//  Created by Yago Marques on 20/06/23.
//

import Foundation

protocol LocalPetIdUseCases {
    func saveId(_ id: String) throws
    func getId() throws -> String
}
