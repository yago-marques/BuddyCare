//
//  FetchPet.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import Foundation

protocol FetchPet {
    func fetchPet() async throws -> DisplayedPet
}
