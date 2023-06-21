//
//  NotRegisterView.swift
//  BuddyCare Watch App
//
//  Created by Emilly Maia on 21/06/23.
//

import SwiftUI

struct NotRegisterView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.98, green: 0.45, blue: 0.63), Color(red: 0.85, green: 0.25, blue: 0.45)]), startPoint: .top, endPoint: .bottom)
                 .edgesIgnoringSafeArea(.all)

            VStack {
                Image("cat2")
                    .frame(height: 100)
                
                Text(" You don't have pets in register! Check the app.")
                    .foregroundColor(.white)
                    .frame(height: 60)
                    .font(.custom("StayPixel-Regular", size: 17))
            }
        }
    }
}

struct NotRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NotRegisterView()
    }
}
