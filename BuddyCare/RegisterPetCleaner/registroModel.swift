//
//  registroViewModel.swift
//  BuddyCare
//
//  Created by Mateus Calisto on 13/06/23.
//

import Foundation
import SwiftUI

class NumberPickerViewModel: ObservableObject {
    @Published var selectedDayTimes: Int = 10
    @Published var selectedWeekTimes: Int = 1
    @Published var selectedLazyTimes: Int = 1
    @Published var selectedTimes: String = "Dias"
    @Published var selectedTime = Date()
    @Published var dates: [Date] = []
    
    @Published var timeOne: Date = Date()
    @Published var timeTwo = Date.now
    @Published var timeThree = Date.now
    
    let lazyTimes: [Int] = Array(1...3)
    let dayTimes: [Int] = Array(5...15)
    let times = ["Dias"]
    
}
