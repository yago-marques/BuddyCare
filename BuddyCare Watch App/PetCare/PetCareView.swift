//
//  PetCareView.swift
//  BuddyCare Watch App
//
//  Created by Emilly Maia on 21/06/23.
//

import SwiftUI

struct PetCareView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.98, green: 0.45, blue: 0.63), Color(red: 0.85, green: 0.25, blue: 0.45)]), startPoint: .top, endPoint: .bottom)
                     .edgesIgnoringSafeArea(.all)
                VStack {
                    Image("cat1")
                        .frame(height: 150)
                    
                    HStack {
                        NavigationLink(destination: PlayNotificationView()) {
                            Text("Play")
                        }
                        .background(Color.white)
                        .foregroundColor(Color(red: 0.85, green: 0.25, blue: 0.45))
                        .cornerRadius(12)
                        .listRowBackground(Color.clear)
                        .padding(.leading, 20)
                        .font(.custom("StayPixel-Regular", size: 17))
                        .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 4)
                        
                                            
                        NavigationLink(destination: HygieneNotificationView()) {
                            Text("Bath")
                        }
                        .background(Color.white)
                        .foregroundColor(Color(red: 0.85, green: 0.25, blue: 0.45))
                        .cornerRadius(12)
                        .listRowBackground(Color.clear)
                        .padding(.trailing, 20)
                        .font(.custom("StayPixel-Regular", size: 17))
                        .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 4)
                    }
                }
            }
            .toolbar(.hidden)
            .foregroundColor(.black)
        }

    }
}

struct PetCareView_Previews: PreviewProvider {
    static var previews: some View {
        PetCareView()
    }
}
