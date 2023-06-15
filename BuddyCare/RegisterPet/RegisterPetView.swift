import SwiftUI

struct RegisterPetView: View {
    @StateObject private var viewModel = RegisterPetViewModel()
    @State private var username: String = ""
    @State private var gender: Gender = .male
    @State private var species: Species = .cat
    @State private var avatar: String = String()
    
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
                        }
                        .listRowBackground(Color.clear)
                    
                    Button("Next") {
                        if username.isEmpty || avatar.isEmpty {
                            print("vc n preencheu tudo")
                        } else {
                            printAlgo()
                        }
                    }
                    .frame(width: 200)
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.bottom, 25)
                    .listRowBackground(Color.clear)
                }
                .foregroundColor(Color.pink)
                .accentColor(.pink)
                .navigationTitle("Let's Start!")
                .navigationBarTitleDisplayMode(.inline)
            }
            
        }
        .environmentObject(viewModel)
    }
    
    func printAlgo() {
          print("\(username), \(gender), \(species), \(avatar)")
      }
}

struct RegisterPetView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPetView()

    }
}
