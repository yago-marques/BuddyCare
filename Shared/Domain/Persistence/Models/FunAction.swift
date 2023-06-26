//
//  FunAction.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import Foundation
import CloudKit

struct FunAction: CKModel, CDModel {
    let id: String
    let petId: String
    var isDone: Int
    let start: Date
    let end: Date

    init(id: String = "", petId: String, isDone: Int, start: Date, end: Date) {
        self.id = id
        self.petId = petId
        self.isDone = isDone
        self.start = start
        self.end = end
    }

    static func make(record: CKRecord) throws -> CKModel {
        guard
            let petId = record["petId"] as? String,
            let isDone = record["isDone"] as? Int,
            let start = record["start"] as? Date,
            let end = record["end"] as? Date
        else {
            throw CKModelError.invalidDecoding
        }

        return FunAction(
            id: record.recordID.recordName,
            petId: petId,
            isDone: isDone,
            start: start,
            end: end
        )
    }

    static func fromData(_ data: Data) throws -> CDModel {
        try JSONDecoder().decode(FunAction.self, from: data)
    }

    func toData() throws -> Data {
        try JSONEncoder().encode(self)
    }

    func record() -> CKRecord {
        let record = CKRecord(recordType: "FunAction")
        record.setValue(self.petId, forKey: "petId")
        record.setValue(self.isDone, forKey: "isDone")
        record.setValue(self.start, forKey: "start")
        record.setValue(self.end, forKey: "end")

        return record
    }
}
