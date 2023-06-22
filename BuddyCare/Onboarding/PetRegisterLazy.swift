//
//  PetRegisterName.swift
//  BuddyCare
//
//  Created by Mateus Calisto on 21/06/23.
//

import Foundation
import SwiftUI


struct PetRegisterLazy: View {
    
    @EnvironmentObject var viewModel: OnboardingModel
    @Binding var idPet: String
    @State private var isActive: Bool = false
    
    var body: some View {
        
        ZStack{
            LinearGradient(colors: [.init(
                UIColor(red: 0.98, green: 0.45, blue: 0.63, alpha: 1.00)), .init(
                    UIColor(red: 0.85, green: 0.25, blue: 0.45, alpha: 1.00))],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            VStack{
                Spacer()
                Text("How many times a day do you want to be reminded to play with your buddy?")
                    .font(Font.custom("StayPixel-Regular", size: 30))
                    .foregroundColor(.white)
                
                
                
                Picker("Dias pra o cachorro cagar", selection: $viewModel.selectedLazyTimes) {
                    ForEach(viewModel.lazyTimes, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .padding(.all, 15.0)
                .pickerStyle(.segmented)
                
                Text("choose the time you want to be reminded:")
                    .font(Font.custom("StayPixel-Regular", size: 30))
                    .foregroundColor(.white)
                
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
                Spacer()
                Button(viewModel.buttonIsActive ? "Start!" : "Loading...") {
                    print("\($viewModel.$petId)")
                    
                    Task {
                        do {
                            print(" de apito\(idPet)")
                            try await viewModel.startButtonHandler(for: idPet)
                            viewModel.isFirstAccess = false
                        } catch {
                            print(" de apito\(idPet)")
                            print("Erro ao criar o pet: \(error)")
                        }
                    }
                }.frame(maxWidth: 325, maxHeight: 50)
                    .background(viewModel.buttonIsActive ? Color.white : .white)
                    .foregroundColor(.pink)
                    .cornerRadius(15)
                    .font(.custom("StayPixel-Regular", size: 24))
                    .shadow(radius: 1, y: 5)
                    .padding(.bottom, 50)
                
                
                NavigationLink(
                    destination:
                        PetRegisterBuddy()
                        .environmentObject(viewModel)
                    ,
                    isActive: $isActive,
                    label: { EmptyView() }
                )
            }
            .navigationBarHidden(true)
        }
        
        .navigationBarHidden(true)
        .navigate(to: PetManagerCompositionRoot.make(), when: $viewModel.navigateToMainView)
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

extension View {
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        ZStack {
            self
                .navigationBarTitle("")
                .navigationBarHidden(true)
            NavigationLink(
                destination: view
                    .navigationBarTitle("")
                    .navigationBarHidden(true),
                isActive: binding
            ) {
                EmptyView()
            }
        }
    }
    
    func deviceWidth(multiplier: Double = 1) -> Double {
        UIScreen.main.bounds.width * multiplier
    }
    
    func deviceHeight(multiplier: Double = 1) -> Double {
        UIScreen().bounds.width * multiplier
    }
}
