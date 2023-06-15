import SwiftUI

struct SelectAvatarTabView: View {
    
    @Binding var species: Species
    @Binding var avatar: String
    var avatars: [String]
    
    var body: some View {
        TabView {
            HStack {
                ForEach(avatars, id: \.self) { selectedAvatar in
                    HStack {
                        Image(selectedAvatar)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(4)
                            .background(selectedAvatar == avatar ? Color.pink : Color.clear)
                            .onTapGesture {
                                avatar = selectedAvatar
                            }
                    }
               
                }
            }
        }
        .frame(width: 350, height: 150)
        .tabViewStyle(.page)
        .accentColor(Color.clear)
    }
}
