import SwiftUI

struct AnimalTypePicker: View {
    @State var index = 0
    @Binding var species: String
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                Image("cat3")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .scaledToFit()
                    .padding(.all, 10)

                Text(" Cat ")
                    .foregroundColor(.pink)
                    .font(Font.custom("StayPixel-Regular", size: 25))
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 55)
            .background((Color.white).opacity(self.index == 0 ? 1 : 0))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onTapGesture { self.index = 0; species = "cat" }
            
            VStack {
                Image("dog3")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .scaledToFit()
                    .padding(.all, 10)
                
                Text("Dog")
                    .foregroundColor(.pink)
                    .font(Font.custom("StayPixel-Regular", size: 25))
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 55)
            .background((Color.white).opacity(self.index == 1 ? 1 : 0))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onTapGesture { self.index = 1; species = "dog" }
        }
//        .padding(4)
        .background(Color(UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.00)))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
