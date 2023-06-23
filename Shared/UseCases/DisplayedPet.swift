//
//  PetDisplayed.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import Foundation

enum PetGender: String {
    case male = "Male"
    case female = "Female"
}

enum PetSpecies: String {
    case cat = "Cat"
    case dog = "Dog"
}

struct DisplayedPet: Identifiable {
    let id: String
    let gender: PetGender
    let species: PetSpecies
    let name: String
    let avatar: String
}

