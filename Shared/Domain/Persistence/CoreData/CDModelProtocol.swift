//
//  CDModel.swift
//  BuddyCare
//
//  Created by Yago Marques on 19/06/23.
//

import Foundation

protocol CDModel: Codable {
    func toData() throws -> Data
    static func fromData(_ data: Data) throws -> CDModel
}
