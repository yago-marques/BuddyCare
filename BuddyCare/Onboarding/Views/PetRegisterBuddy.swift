//
//  PetRegisterName.swift
//  BuddyCare
//
//  Created by Mateus Calisto on 21/06/23.
//

import Foundation
import SwiftUI


struct PetRegisterBuddy: View {
    
    @EnvironmentObject var viewModel: OnboardingModel
    
    @State var presentAlert = false
    @State private var isActive: Bool = false
    @State private var species: String = "cat"
    @State private var avatar: String = ""
    @State private var genderAll: String = "male"
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
                Text("IS \(viewModel.username) A CAT OR DOG?")
                    .font(Font.custom("StayPixel-Regular", size: 30))
                    .foregroundColor(.white)
                    .padding(.bottom, 35)
                AnimalTypePicker(species: $species) 
                Text("AND IT'S LOOK LIKE:")
                    .font(Font.custom("StayPixel-Regular", size: 30))
                    .foregroundColor(.white)
                    .padding(.top, 50)
                SelectAvatarTabView(
                    species: $species,
                    avatar: $avatar,
                    avatars: viewModel.avatars[species]!
                )
                Spacer()
                Button("Next") {
                    if avatar.isEmpty {
                        withAnimation{
                            presentAlert.toggle()
                        }
                    }else{
                        isActive = true
                        Task {
                            do {
                                let pet = Pet (
                                    name: viewModel.username,
                                    gender: genderAll,
                                    species: species,
                                    avatar: avatar
                                )
                                try await viewModel.nextButtonHandler(with: pet)
                            } catch {
                                print("Erro ao criar o pet: \(error)")
                            }
                        }
                    }
                }.frame(maxWidth: 325, maxHeight: 50)
                    .background(.white)
                    .foregroundColor(.pink)
                    .font(.custom("StayPixel-Regular", size: 24))
                    .cornerRadius(15)
                    .shadow(radius: 1, y: 5)
                .padding(.bottom, 50)
                
                NavigationLink(
                    destination:
                        PetRegisterBath()
                        .environmentObject(viewModel)
                    ,
                    isActive: $isActive,
                    label: { EmptyView() }
                )
            }
        }
        .navigationBarHidden(true)
        .overlay{
            if presentAlert{
                CustomAlert(presentAlert: $presentAlert, alertType: .error(title: "OOOOOPS...", message: "select a companion that most resembles yours"), isShowVerticalButtons: false){
                    withAnimation{
                        presentAlert.toggle()
                    }
                } rightButtonAction: {
                    withAnimation{
                        presentAlert.toggle()
                    }
                }
            }
        }
        .onAppear {
            PetNotifications.shared.checkForNotificationAuthorization()
        }

    }
}
