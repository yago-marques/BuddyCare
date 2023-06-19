import SwiftUI

struct AnimalTypePicker: View {
    @State var index = 0
    @Binding var species: String
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                Image("cat2")
                    .resizable()
                    .foregroundColor(self.index == 0 ? .black : .gray)
                    .frame(width: 60, height: 60, alignment: .center)
                
                Text(" Cat ")
                    .foregroundColor(self.index == 0 ? .black : .gray)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 55)
            .background((Color.white).opacity(self.index == 0 ? 1 : 0))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onTapGesture { self.index = 0; species = "cat" }
            
            VStack {
                Image("dog2")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .center)
                    .foregroundColor(self.index == 1 ? .black : .gray)
                
                Text("Dog")
                    .foregroundColor(self.index == 1 ? .black : .gray)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 55)
            .background((Color.white).opacity(self.index == 1 ? 1 : 0))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onTapGesture { self.index = 1; species = "dog" }
        }
        .padding(4)
        .background(Color.black.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
