//
//  PlayNotificationView.swift
//  BuddyCare Watch App
//
//  Created by Emilly Maia on 21/06/23.
//

import SwiftUI

struct PlayNotificationView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.98, green: 0.45, blue: 0.63), Color(red: 0.85, green: 0.25, blue: 0.45)]), startPoint: .top, endPoint: .bottom)
                 .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Text("'name' needs attention!")
                    .font(.custom("StayPixel-Regular", size: 17))
                    .foregroundColor(.white)
                    .padding(.bottom)
                
                Image("cat1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                   
                
                VStack {
                    Button("Play now!") {
                        
                    }
                    .background(Color.white)
                    .foregroundColor(Color(red: 0.85, green: 0.25, blue: 0.45))
                    .cornerRadius(12)
                    .listRowBackground(Color.clear)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .font(.custom("StayPixel-Regular", size: 17))
                    .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 4)
                                        
                }
            }
        }
    }
}

struct PlayNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        PlayNotificationView()
    }
}
