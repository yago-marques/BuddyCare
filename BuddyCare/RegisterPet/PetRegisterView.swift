//
//  RegisterScrollViewPet.swift
//  BuddyCare
//
//  Created by Mateus Calisto on 19/06/23.
//

import Foundation
import SwiftUI

struct RegisterPetView: View {

        @StateObject private var viewModel = RegisterPetViewModel()
        @State private var username: String = ""
        @State private var gender: String = "male"
        @State private var species: String = "cat"
        @State private var avatar: String = ""

    @State private var navigateToCleaner: Bool = false
    @State private var idPed: String = ""

    var body: some View {
        ZStack{
            Color.init(UIColor(red: 0.95, green: 0.92, blue: 0.98, alpha: 1.00))
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 0) {
                    Text("What is your pet’s name?")
                        .font(.subheadline)
                        .foregroundColor(Color.pink)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 15.0)
                        .padding(.top, 30.0)

                    TextField("Username",
                              text: $username,
                              prompt: Text("Insert here a name!"))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .multilineTextAlignment(.center)
                    Text("Is your pet male or female?")
                        .font(.subheadline)
                        .foregroundColor(Color.pink)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 15)
                        .padding(.top, 20)
                        .padding(.bottom, 20)

                    GenderPicker(gender: $gender)
                        .listRowBackground(Color.clear)
                        .listRowSeparatorTint(.clear)

                            Text("Is your pet a cat or a dog?")
                                .font(.subheadline)
                                .foregroundColor(Color.pink)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 15)
                                .padding(.top, 30)
                                .padding(.bottom, 20)
                            AnimalTypePicker(species: $species)

                        .listRowBackground(Color.clear)
                        .listRowSeparatorTint(.clear)

                            Text("Select Your Buddy")
                                .font(.subheadline)
                                .foregroundColor(Color.pink)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 15)
                                .padding(.top, 30)
                                .padding(.bottom, 10)
                    SelectAvatarTabView(
                        species: $species,
                        avatar: $avatar,
                        avatars: viewModel.avatars[species]!
                    )

                    Button(viewModel.buttonIsActive ? "Next" : "Loading...") {
                        if username.isEmpty || avatar.isEmpty {
                            print("vc n preencheu tudo")
                        } else if viewModel.buttonIsActive {
                            Task {
                                do {
                                    let pet = Pet (
                                        name: username,
                                        gender: gender,
                                        species: species,
                                        avatar: avatar
                                    )

                                    try await viewModel.nextButtonHandler(with: pet)
                                } catch {
                                    print("Erro ao criar o pet: \(error)")
                                }
                            }
                        }
                    }
                            .frame(maxWidth: 350, maxHeight: 30)
                            .background(viewModel.buttonIsActive ? Color.pink : .gray)
                                .padding(8)
                                .background(Color.pink)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .padding(.bottom, 30)
                            .listRowSeparatorTint(.clear)
                        }
                        .listRowBackground(Color.clear)
                }
                .foregroundColor(Color.pink)
                .accentColor(.pink)
                .listStyle(.insetGrouped)
                .navigationTitle("Let's Start!")
                .navigationBarTitleDisplayMode(.inline)
            }

        .environmentObject(viewModel)
        .navigate(to: registroView(idPet: $viewModel.petId), when: $viewModel.navigateToCleaner)
    }
}

extension View {
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
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
        .navigationViewStyle(.stack)
    }

    func deviceWidth(multiplier: Double = 1) -> Double {
        UIScreen.main.bounds.width * multiplier
    }

    func deviceHeight(multiplier: Double = 1) -> Double {
        UIScreen().bounds.width * multiplier
    }
}
