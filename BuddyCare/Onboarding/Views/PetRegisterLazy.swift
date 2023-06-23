//
//  PetRegisterName.swift
//  BuddyCare
//
//  Created by Mateus Calisto on 21/06/23.
//

import Foundation
import SwiftUI


struct PetRegisterLazy: View {
    
    @Environment(\.dismiss) private var dismiss
    
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
                Text("How many times a day do you want to be reminded to play with \(viewModel.username)?")
                    .font(Font.custom("StayPixel-Regular", size: 30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(30)
                
                Picker("Days pra o cachorro cagar", selection: $viewModel.selectedLazyTimes) {
                    ForEach(viewModel.lazyTimes, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .pickerStyle(.segmented)
                .colorScheme(.light)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 20)
                
                
                Text("choose the time you want to be reminded")
                    .font(Font.custom("StayPixel-Regular", size: 30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(30)
                
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
//            .navigationBarHidden(true)
        }
        
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: backButton)
        .navigate(to: PetManagerCompositionRoot.make(), when: $viewModel.navigateToMainView)
    }
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(systemName: "lessthan")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                
                    .padding(.bottom, 3)
                Text("Back")
                    .font(Font.custom("StayPixel-Regular", size: 30))
                    .foregroundColor(.white)
            }
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
        .colorScheme(.light)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
}
