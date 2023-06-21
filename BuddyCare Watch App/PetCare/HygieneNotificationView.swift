//
//  HygieneNotificationView.swift
//  BuddyCare Watch App
//
//  Created by Emilly Maia on 21/06/23.
//

import SwiftUI

struct HygieneNotificationView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.98, green: 0.45, blue: 0.63), Color(red: 0.85, green: 0.25, blue: 0.45)]), startPoint: .top, endPoint: .bottom)
                 .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Text("Change the litter pls!")
                    .padding(.bottom)
                    .foregroundColor(.white)
                    .font(.custom("StayPixel-Regular", size: 17))


                
                Image("catHygiene")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
                    .padding()
                   
                
                VStack {
                    Button("Clean up now!") {
                        
                    }
                    .background(Color.white)
                    .foregroundColor(Color(red: 0.85, green: 0.25, blue: 0.45))
                    .cornerRadius(12)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .padding(.top)
                    .font(.custom("StayPixel-Regular", size: 17))
                    .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 4)
                                        
                }
            }
        }
    }
}

struct HygieneNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        HygieneNotificationView()
    }
}
