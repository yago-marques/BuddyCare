import Foundation

import SwiftUI

enum Gender: Hashable {
    case female
    case male
}

struct GenderPicker: View {
    @State var index = 0
    @Binding var gender: Gender
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                Image("male")
                    .resizable()
                    .foregroundColor(self.index == 0 ? .black : .gray)
                    .frame(width: 70, height: 70, alignment: .center)
                
                Text(" Male ")
                    .foregroundColor(self.index == 0 ? .black : .gray)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 50)
            .background((Color.white).opacity(self.index == 0 ? 1 : 0))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onTapGesture { self.index = 0; gender = .male }
            
            VStack {
                Image("female")
                    .resizable()
                    .frame(width: 70, height: 70, alignment: .center)
                    .foregroundColor(self.index == 1 ? .black : .gray)
                
                Text("Female")
                    .foregroundColor(self.index == 1 ? .black : .gray)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 50)
            .background((Color.white).opacity(self.index == 1 ? 1 : 0))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onTapGesture { self.index = 1; gender = .male }
        }
        .padding(4)
        .background(Color.black.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
