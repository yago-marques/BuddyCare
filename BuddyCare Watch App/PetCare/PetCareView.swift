import SwiftUI

struct PetCareView: View {
    var body: some View {
        ZStack {
            Color.init(red: 0.95, green: 0.92, blue: 0.98)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("cat1")
                
                HStack {
                    Button("Play") {
                        
                    }
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.bottom, 40)
                    .listRowBackground(Color.clear)
                    
                    Button("Bath") {
                        
                    }
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.bottom, 40)
                    .listRowBackground(Color.clear)
                }
            }
        }
        .foregroundColor(.black)
    }
}

struct PetCareView_Previews: PreviewProvider {
    static var previews: some View {
        PetCareView()
    }
}
