//
//  registroViewModel.swift
//  BuddyCare
//
//  Created by Mateus Calisto on 13/06/23.
//

import Foundation
import SwiftUI

class NumberPickerViewModel: ObservableObject {
    @Published var selectedDayTimes: Int = 5
    @Published var selectedWeekTimes: Int = 1
    @Published var selectedLazyTimes: Int = 1
    @Published var selectedTimes: String = "Dias"
    @Published var selectedTime = Date()
    
    @Published var timeOne = Date.now
    @Published var timeTwo: Date = Date()
    @Published var timeThree: Date = Date()
    
    
    let lazyTimes: [Int] = Array(1...3)
    let dayTimes: [Int] = Array(5...15)
    let weekTimes: [Int] = Array(1...4)
    let times = ["Dias", "Semanas"]
    
}
