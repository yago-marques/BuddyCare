//
//  CKModelProtocol.swift
//  BuddyCare
//
//  Created by Yago Marques on 13/06/23.
//

import Foundation
import CloudKit

protocol CKModel {
    static func make(record: CKRecord) throws -> CKModel
    func record() -> CKRecord
}
