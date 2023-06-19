//
//  BathAction.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import Foundation
import CloudKit

struct BathAction: CKModel {
    let id: String
    let petId: String
    let isDone: Int
    let day: Date

    init(id: String = "", petId: String, isDone: Int, day: Date) {
        self.id = id
        self.petId = petId
        self.isDone = isDone
        self.day = day
    }

    static func make(record: CKRecord) throws -> CKModel {
        guard
            let petId = record["petId"] as? String,
            let isDone = record["isDone"] as? Int,
            let day = record["day"] as? Date
        else {
            throw CKModelError.invalidDecoding
        }

        return BathAction(
            id: record.recordID.recordName,
            petId: petId,
            isDone: isDone,
            day: day
        )
    }

    func record() -> CKRecord {
        let record = CKRecord(recordType: "BathAction")
        record.setValue(self.petId, forKey: "petId")
        record.setValue(self.isDone, forKey: "isDone")
        record.setValue(self.day, forKey: "day")

        return record
    }
}
