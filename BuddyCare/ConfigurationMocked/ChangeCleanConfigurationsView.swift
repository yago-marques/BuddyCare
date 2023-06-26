//
//  ChangePlayConfigurationsView.swift
//  BuddyCare
//
//  Created by Emilly Maia on 26/06/23.
//

import SwiftUI

struct ChangeCleanConfigurationsView: View {
    @EnvironmentObject var viewModel: PetManagerViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var isActive: Bool = false
    @State private var index = 0
    @State var specie = "cat"
    private var days = ["DAYS"]
    
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
                if specie == "dog"{
                    Text("How often do you want to be reminded to bathe your buddy)?")
                        .font(Font.custom("StayPixel-Regular", size: 30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(30)
                } else {
                    Text("How many times a day do you want to be reminded to clean the your buddy litter box ?")
                        .font(Font.custom("StayPixel-Regular", size: 30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(30)
                }
                
                HStack(spacing: 0) {
                    Picker("Select an option", selection: $index ) {
                        ForEach(5...15, id: \.self) { number in
                            Text("\(number)").tag(number)
                                .foregroundColor(.white)
                                .font(.system(size: 30, design: .rounded))
                                .fontWeight(.bold)
                            
                        }
                    }
                    .pickerStyle(.wheel)
                    Picker("Select an option", selection: $index) {
                        ForEach(days, id: \.self) { d in
                            Text("\(d)").tag(d)
                                .foregroundColor(.white)
                                .font(.system(size: 30, design: .rounded))
                                .fontWeight(.bold)
                        }
                    }
                    .pickerStyle(.wheel)
                }.padding(.top, -20)
                    .padding(.horizontal, 30)
                Spacer()
                Button("SAVE") {
//                    isActive = true
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
