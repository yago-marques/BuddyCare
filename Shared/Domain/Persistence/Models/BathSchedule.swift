//
//  BathSchedule.swift
//  BuddyCare
//
//  Created by Yago Marques on 13/06/23.
//

import Foundation
import CloudKit

struct BathSchedule: CKModel, CDModel {
    var id: String
    let petId: String
    let frequency: Int

    init(id: String = "", petId: String, frequency: Int) {
        self.id = id
        self.petId = petId
        self.frequency = frequency
    }

    init(id: String = "", frequency: Int) {
        self.id = id
        self.petId = ""
        self.frequency = frequency
    }

    static func fromData(_ data: Data) throws -> CDModel {
        try JSONDecoder().decode(BathSchedule.self, from: data)
    }

    func toData() throws -> Data {
        try JSONEncoder().encode(self)
    }

    static func make(record: CKRecord) throws -> CKModel {
        guard
            let petID = record["petId"] as? String,
            let frequency = record["frequency"] as? Int
        else {
            throw CKModelError.invalidDecoding
        }

        return BathSchedule(id: record.recordID.recordName, petId: petID, frequency: frequency)
    }

    func record() -> CKRecord {
        let record = CKRecord(recordType: "BathSchedule")
        record.setValue(self.petId, forKey: "petId")
        record.setValue(self.frequency, forKey: "frequency")

        return record
    }
}
