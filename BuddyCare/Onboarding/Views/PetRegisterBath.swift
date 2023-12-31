//
//  PetRegisterName.swift
//  BuddyCare
//
//  Created by Mateus Calisto on 21/06/23.
//

import Foundation
import SwiftUI


struct PetRegisterBath: View {
    
    @EnvironmentObject var viewModel: OnboardingModel
    @Environment(\.dismiss) private var dismiss
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
                if viewModel.selectedSpecies == "dog"{
                    Text("How often do you want to be reminded to bathe \(viewModel.username)?")
                        .font(Font.custom("StayPixel-Regular", size: 30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(30)
                } else {
                    Text("How many times a day do you want to be reminded to clean the \(viewModel.username) litter box ?")
                        .font(Font.custom("StayPixel-Regular", size: 30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(30)
                }
                
                HStack(spacing: 0) {
                    Picker("Selecione uma opção", selection: $viewModel.selectedDayTimes) {
                        ForEach(viewModel.dayTimes, id: \.self) { number in
                            Text("\(number)").tag(number)
                                .foregroundColor(.white)
                            //                                .font(Font.custom("StayPixel-Regular", size: 20))
                                .font(.system(size: 30, design: .rounded))
                                .fontWeight(.bold)
                            
                        }
                    }
                    .pickerStyle(.wheel)
                    Picker("Selecione uma opção", selection: $viewModel.selectedTimes) {
                        ForEach(viewModel.times, id: \.self) { times in
                            Text("\(times)").tag(times)
                                .foregroundColor(.white)
                            //                                .font(Font.custom("StayPixel-Regular", size: 30))
                                .font(.system(size: 30, design: .rounded))
                                .fontWeight(.bold)
                            //                                .font(.system(size: 30, design: .rounded))
                        }
                    }
                    .pickerStyle(.wheel)
                }.padding(.top, -20)
                    .padding(.horizontal, 30)
                Spacer()
                Button("Next") {
                    isActive = true
                    
                }.frame(maxWidth: 325, maxHeight: 50)
                    .background(.white)
                    .foregroundColor(.pink)
                    .font(.custom("StayPixel-Regular", size: 24))
                    .cornerRadius(15)
                    .shadow(radius: 1, y: 5)
                    .padding(.bottom, 50)
                
                NavigationLink(
                    destination:
                        PetRegisterLazy(idPet: $viewModel.petId)
                        .environmentObject(viewModel)
                    ,
                    isActive: $isActive,
                    label: { EmptyView() }
                )
            }
        }
        
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: backButton)
        .navigate(to: PetRegisterLazy(idPet: $viewModel.petId), when: $viewModel.navigateToCleaner)
       
        
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
