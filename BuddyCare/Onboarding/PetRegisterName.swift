//
//  PetRegisterName.swift
//  BuddyCare
//
//  Created by Mateus Calisto on 21/06/23.
//

import Foundation
import SwiftUI


struct PetRegisterName: View {
    
    @EnvironmentObject var viewModel: OnboardingModel
    
    @State private var username: String = ""
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [.init(
                    UIColor(red: 0.98, green: 0.45, blue: 0.63, alpha: 1.00)), .init(
                        UIColor(red: 0.85, green: 0.25, blue: 0.45, alpha: 1.00))],
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                VStack{
                    Spacer()
                    Text("What's is your buddy name?")
                        .font(Font.custom("StayPixel-Regular", size: 30))
                        .foregroundColor(.white)
                    TextField("Type Here...", text: $viewModel.username)
                        .textFieldStyle(.plain)
                        .padding(.top, 30)
                        .multilineTextAlignment(.center)
                        .font(Font.custom("StayPixel-Regular", size: 35))
                        .foregroundColor(.white)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white)
                        .padding(.horizontal, 100)
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
                            PetRegisterBuddy()
                            .environmentObject(viewModel)
                        ,
                        isActive: $isActive,
                        label: { EmptyView() }
                    )
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .navigate(to: PetRegisterLazy(idPet: $viewModel.petId), when: $viewModel.navigateToCleaner)
    }
}
