import SwiftUI

struct RegisterPetView: View {
    
    @StateObject private var viewModel = RegisterPetViewModel()
    @State private var username: String = ""
    @State private var gender: String = "male"
    @State private var species: String = "cat"
    @State private var avatar: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    Section(
                        header: Text("What is your pet’s name?")) {
                            TextField("Username",
                                      text: $username,
                                      prompt: Text("Required"))
                        }
                    
                    Section(
                        header: Text("Is your pet male or female?")) {
                            GenderPicker(gender: $gender)
                        }
                        .listRowBackground(Color.clear)
#if os(iOS)
                        .listRowSeparatorTint(.clear)
#endif
                    
                    Section(
                        header: Text("Is your pet a cat or a dog?")) {
                            AnimalTypePicker(species: $species)
                        }
                        .listRowBackground(Color.clear)
#if os(iOS)
                        .listRowSeparatorTint(.clear)
#endif
                    
                    Section(
                        header: Text("Select Your Buddy")) {
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
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(8)
                            .background(viewModel.buttonIsActive ? Color.pink : .gray)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.bottom, 30)
                            .listRowBackground(Color.clear)
#if os(iOS)
                            .listRowSeparatorTint(.clear)
#endif
                        }
                        .listRowBackground(Color.clear)
                }
                .foregroundColor(Color.pink)
                .accentColor(.pink)
                .navigationTitle("Let's Start!")
                .navigationBarTitleDisplayMode(.inline)
            }
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
