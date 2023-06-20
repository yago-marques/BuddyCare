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
            throw CKModelError.invalidDecoding
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
