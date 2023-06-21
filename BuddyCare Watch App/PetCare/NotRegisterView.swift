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
            Color.init(red: 0.95, green: 0.92, blue: 0.98)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("cat2")
                    .frame(height: 100)
                
                Text("You don't have pets in register! Check the app.")
                    .foregroundColor(.black)
                    .frame(height: 60)
            }
        }
    }
}

struct NotRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NotRegisterView()
    }
}
