//
//  Pet.swift
//  BuddyCare
//
//  Created by Gabriel Santiago on 12/06/23.
//

import Foundation
import CloudKit

struct Pet: CKModel {
    let id: String
    let name: String
    let gender: String
    let species: String
    let avatar: String

    init(id: String = "", name: String, gender: String, species: String, avatar: String) {
        self.id = id
        self.name = name
        self.gender = gender
        self.species = species
        self.avatar = avatar
    }

    static func make(record: CKRecord) throws -> CKModel {
        guard
            let name = record["name"] as? String,
            let gender = record["gender"] as? String,
            let species = record["species"] as? String,
            let avatar = record["avatar"] as? String
        else {
            throw PetModelError.invalidDecoding
        }

        return Pet(id: record.recordID.recordName, name: name, gender: gender, species: species, avatar: avatar)
    }

    func record() -> CKRecord {
        let record = CKRecord(recordType: "Pet")
        record.setValue(self.name, forKey: "name")
        record.setValue(self.gender, forKey: "gender")
        record.setValue(self.species, forKey: "species")
        record.setValue(self.avatar, forKey: "avatar")

        return record
    }
}

struct BathSchedule: CKModel {
    let petId: String
    let frequency: Int
    let times: [Date]

    static func make(record: CKRecord) throws -> CKModel {
        guard
            let petID = record["petId"] as? String,
            let frequency = record["frequency"] as? Int,
            let times = record["times"] as? [Date]
        else {
            throw PetModelError.invalidDecoding
        }

        return BathSchedule(petId: petID, frequency: frequency, times: times)
    }

    func record() -> CKRecord {
        let record = CKRecord(recordType: "BathSchedule")
        record.setValue(self.petId, forKey: "petId")
        record.setValue(self.frequency, forKey: "frequency")
        record.setValue(self.times, forKey: "times")

        return record
    }
}

struct FunSchedule: CKModel {
    let petId: String
    let frequency: Int
    let times: [Date]

    static func make(record: CKRecord) throws -> CKModel {
        guard
            let petID = record["petId"] as? String,
            let frequency = record["frequency"] as? Int,
            let times = record["times"] as? [Date]
        else {
            throw PetModelError.invalidDecoding
        }

        return FunSchedule(petId: petID, frequency: frequency, times: times)
    }

    func record() -> CKRecord {
        let record = CKRecord(recordType: "BathSchedule")
        record.setValue(self.petId, forKey: "petId")
        record.setValue(self.frequency, forKey: "frequency")
        record.setValue(self.times, forKey: "times")

        return record
    }
}

enum PetModelError: Error {
    case invalidDecoding
}

protocol CKModel {
    static func make(record: CKRecord) throws -> CKModel
    func record() -> CKRecord
}
