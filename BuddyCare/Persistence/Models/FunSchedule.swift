//
//  FunSchedule.swift
//  BuddyCare
//
//  Created by Yago Marques on 13/06/23.
//

import Foundation
import CloudKit

struct FunSchedule: CKModel, CDModel {
    var id: String
    let petId: String
    let frequency: Int
    let times: [Date]

    init(id: String = "", petId: String, frequency: Int, times: [Date]) {
        self.id = id
        self.petId = petId
        self.frequency = frequency
        self.times = times
    }

    init(id: String = "", frequency: Int, times: [Date]) {
        self.id = id
        self.petId = ""
        self.frequency = frequency
        self.times = times
    }

    static func make(record: CKRecord) throws -> CKModel {
        guard
            let petID = record["petId"] as? String,
            let frequency = record["frequency"] as? Int,
            let times = record["times"] as? [Date]
        else {
            throw CKModelError.invalidDecoding
        }

        return FunSchedule(id: record.recordID.recordName,petId: petID, frequency: frequency, times: times)
    }

    static func fromData(_ data: Data) throws -> CDModel {
        try JSONDecoder().decode(FunSchedule.self, from: data)
    }

    func toData() throws -> Data {
        try JSONEncoder().encode(self)
    }

    func record() -> CKRecord {
        let record = CKRecord(recordType: "FunSchedule")
        record.setValue(self.petId, forKey: "petId")
        record.setValue(self.frequency, forKey: "frequency")
        record.setValue(self.times, forKey: "times")

        return record
    }
}
