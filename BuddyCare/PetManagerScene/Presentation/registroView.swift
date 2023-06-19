//
//  registroView.swift
//  BuddyCare
//
//  Created by Mateus Calisto on 13/06/23.
//

import Foundation
import SwiftUI

struct registroView: View {
    
    @StateObject private var viewModel = NumberPickerViewModel()
    @State private var isPickerShown: Bool = false
    
    var body: some View {
        VStack {
            Form {
                Section(){
                    Text("Higiene")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                    
                    Button("Valor selecionado: \(viewModel.selectedDayTimes) \(viewModel.selectedTimes).") {
                        isPickerShown = true
                    }
                    .sheet(isPresented: $isPickerShown) {
                        GeometryReader { geometry in
                            HStack(spacing: 0) {
                                Picker("Selecione uma opção", selection: $viewModel.selectedDayTimes) {
                                    ForEach(viewModel.dayTimes, id: \.self) { number in
                                        Text("\(number)").tag(number)
                                    }
                                }
                                .frame(maxWidth: geometry.size.width / 2)
                                .pickerStyle(.wheel)
                                Picker("Selecione uma opção", selection: $viewModel.selectedTimes) {
                                    ForEach(viewModel.times, id: \.self) { times in
                                        Text("\(times)").tag(times)
                                    }
                                }
                                .frame(maxWidth: geometry.size.width / 2)
                                .pickerStyle(.wheel)
                            }
                        }
                        .presentationDetents([.height(200)])
                        Button("Confirmar") {
                            isPickerShown = false
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(Color.black)
                    }
                }
                Section {
                    Text("Lazer")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                    Picker("Dias pra o cachorro cagar", selection: $viewModel.selectedLazyTimes) {
                        ForEach(viewModel.lazyTimes, id: \.self) { number in
                            Text("\(number)").tag(number)
                            
                            
                        }
                        
                    }
                    .pickerStyle(.segmented)
                    
                    if viewModel.selectedLazyTimes == 1 {
                        TimePicker(selectedTime: $viewModel.timeOne)
                            .padding(.all)
                            .frame(maxWidth: .infinity)
                    } else if viewModel.selectedLazyTimes == 2 {
                        HStack(spacing: 30) {
                            TimePicker(selectedTime: $viewModel.timeOne)
                            TimePicker(selectedTime: $viewModel.timeTwo)
                        }
                        .padding(.all)
                        .frame(maxWidth: .infinity)
                    } else {
                        HStack(spacing: 30) {
                            TimePicker(selectedTime: $viewModel.timeOne)
                            TimePicker(selectedTime: $viewModel.timeTwo)
                            TimePicker(selectedTime: $viewModel.timeThree)
                        }
                        .padding(.all)
                        .frame(maxWidth: .infinity)
                    }
                    Button("Confirmar") {
                        Task {
                            do {
                                if viewModel.selectedLazyTimes == 1{
                                    try await CloudKitService.shared.createFunSchedule(FunSchedule(frequency: viewModel.selectedLazyTimes, times: viewModel.dates))
                                    try await CloudKitService.shared.createBathSchedule(BathSchedule(frequency: viewModel.selectedDayTimes))
                                }
                                else if viewModel.selectedLazyTimes == 2{
                                    try await CloudKitService.shared.createFunSchedule(FunSchedule(frequency: viewModel.selectedLazyTimes, times: viewModel.dates))
                                    try await CloudKitService.shared.createBathSchedule(BathSchedule(frequency: viewModel.selectedDayTimes))
                                }else{
                                    try await CloudKitService.shared.createFunSchedule(FunSchedule(frequency: viewModel.selectedLazyTimes, times: viewModel.dates))
                                    try await CloudKitService.shared.createBathSchedule(BathSchedule(frequency: viewModel.selectedDayTimes))
                                }
                            }catch {
                                print("Erro ao criar o pet: \(error)")
                            }
                        }
                    }
                    
                    
                }
                
            }
        }
    }
    
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
}


struct TimePicker: View {
    @Binding var selectedTime: Date
    
    var body: some View {
        DatePicker(
            "Hours",
            selection: $selectedTime,
            displayedComponents: [.hourAndMinute]
        )
        .labelsHidden()
        .datePickerStyle(CompactDatePickerStyle())
    }
}
