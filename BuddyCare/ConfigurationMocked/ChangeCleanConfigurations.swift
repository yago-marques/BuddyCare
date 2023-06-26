//
//  ChangeCleanConfigurations.swift
//  BuddyCare
//
//  Created by Mateus Calisto on 26/06/23.
//

import Foundation
import SwiftUI

struct ChangeCleanConfigurations: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedOption = 1
    @State var viewModel = OnboardingModel()
    
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
                Text("How many times a day do you want to be reminded to play with buddy?")
                    .font(Font.custom("StayPixel-Regular", size: 30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(30)
                
                Picker("Opções", selection: $selectedOption) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
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
                HStack{
                    if selectedOption == 1 {
                        TimePicker(selectedTime: $viewModel.timeOne)
                            .padding(.all)
                            .frame(maxWidth: .infinity)
                    } else if selectedOption == 2 {
                        TimePicker(selectedTime: $viewModel.timeOne)
                            .padding(.all)
                            .frame(maxWidth: .infinity)
                        TimePicker(selectedTime: $viewModel.timeTwo)
                            .padding(.all)
                            .frame(maxWidth: .infinity)
                    } else if selectedOption == 3 {
                        TimePicker(selectedTime: $viewModel.timeOne)
                            .padding(.all)
                            .frame(maxWidth: .infinity)
                        TimePicker(selectedTime: $viewModel.timeTwo)
                            .padding(.all)
                            .frame(maxWidth: .infinity)
                        TimePicker(selectedTime: $viewModel.timeThree)
                            .padding(.all)
                            .frame(maxWidth: .infinity)
                    }
                    
                }
                Spacer()
                Button("SAVE") {
                    dismiss()
                    
                }.frame(maxWidth: 325, maxHeight: 50)
                    .background(.white)
                    .foregroundColor(.init(red: 0.85, green: 0.25, blue: 0.45))
                    .font(.custom("StayPixel-Regular", size: 24))
                    .cornerRadius(15)
                    .shadow(radius: 1, y: 5)
                    .padding(.bottom, 50)
            }
          
        }
        .foregroundColor(.white)
        .font(.custom("StayPixel-Regular", size: 17))
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: backButton)
        
    }
    
    
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                
                    .padding(.bottom, 3)
                Text("Back")
                    .font(Font.custom("StayPixel-Regular", size: 17))
                    .foregroundColor(.white)
            }
        }
    }
}

