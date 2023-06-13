//
//  registroViewModel.swift
//  BuddyCare
//
//  Created by Mateus Calisto on 13/06/23.
//

import Foundation
import SwiftUI

class NumberPickerViewModel: ObservableObject {
    @Published var selectedNumber: Int = 5 // Valor inicial selecionado
    
    let numbers: [Int] = Array(5...15) // Array com os números disponíveis no picker
}
