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
        ZStack{
            Color.init(UIColor(red: 0.95, green: 0.92, blue: 0.98, alpha: 1.00))
                .ignoresSafeArea()
            VStack {
                Text("Hygiene")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
                    .padding()
                Text("How often do you want to be reminded to change your cat litter?")
                    .font(.subheadline)
                    .foregroundColor(Color.pink)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 15.0)
                
                HStack(spacing: 0) {
                    Picker("Selecione uma opção", selection: $viewModel.selectedDayTimes) {
                        ForEach(viewModel.dayTimes, id: \.self) { number in
                            Text("\(number)").tag(number)
                        }
                    }
                    .pickerStyle(.wheel)
                    Picker("Selecione uma opção", selection: $viewModel.selectedTimes) {
                        ForEach(viewModel.times, id: \.self) { times in
                            Text("\(times)").tag(times)
                        }
                    }
                    .pickerStyle(.wheel)
                }.padding(.top, -20)
                    .padding(.horizontal, 30)
                
                Text("Play Time")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
                Text("How many times a day do you want to be reminded to play with your cat?")
                    .font(.subheadline)
                    .foregroundColor(Color.pink)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 15.0)
                    .padding(.top, 5.0)
                
                
                
                Picker("Dias pra o cachorro cagar", selection: $viewModel.selectedLazyTimes) {
                    ForEach(viewModel.lazyTimes, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .padding(.all, 15.0)
                .pickerStyle(.segmented)
                
                Text("Choose the time you want to be reminded:")
                    .font(.subheadline)
                    .foregroundColor(Color.pink)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 15.0)
                    .padding(.top, 5.0)
                
                
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
                Button("Start!") {
                    Task {
                        do {
                            if viewModel.selectedLazyTimes == 1{
                                try await CloudKitService.shared.createFunSchedule(FunSchedule(frequency: viewModel.selectedLazyTimes, times: viewModel.dates))
                                try await CloudKitService.shared.createBathSchedule(BathSchedule(frequency: viewModel.selectedDayTimes, times: [viewModel.timeOne]))
                            }
                            else if viewModel.selectedLazyTimes == 2{
                                try await CloudKitService.shared.createFunSchedule(FunSchedule(frequency: viewModel.selectedLazyTimes, times: viewModel.dates))
                                try await CloudKitService.shared.createBathSchedule(BathSchedule(frequency: viewModel.selectedDayTimes, times: [viewModel.timeOne, viewModel.timeTwo]))
                            }else{
                                try await CloudKitService.shared.createFunSchedule(FunSchedule(frequency: viewModel.selectedLazyTimes, times: viewModel.dates))
                                try await CloudKitService.shared.createBathSchedule(BathSchedule(frequency: viewModel.selectedDayTimes, times: [viewModel.timeOne, viewModel.timeTwo, viewModel.timeThree]))
                            }
                        }catch {
                            print("Erro ao criar o pet: \(error)")
                        }
                    }
                }.frame(maxWidth: 350, maxHeight: 30)
                    .padding(8)
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.bottom, 30)
                
            }
            Spacer()
        }
    }
}
private func formattedTime(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter.string(from: date)
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
