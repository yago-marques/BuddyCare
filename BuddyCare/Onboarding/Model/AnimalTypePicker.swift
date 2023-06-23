import SwiftUI

struct AnimalTypePicker: View {
    @State var index = 0
    @Binding var species: String
    
    var species2: [String] = ["WhiteCat", "WhiteDog"]
    @State var selectedAvatar: String = ""
    
    var body: some View {

        HStack {
            ForEach((0...1), id: \.self) { index in
                Image(species2[index])
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(4)
                    .background(selectedAvatar == species2[index] ? .white : .clear)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .onTapGesture {
                        selectedAvatar = species2[index]
                        if index == 0 {
                            species = "cat"
                        } else if index == 1 {
                            species = "dog"
                        }
                    }
            }
        }
    }
}
