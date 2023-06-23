//
//  PetBathView.swift
//  BuddyCare
//
//  Created by Emilly Maia on 23/06/23.
//

import SwiftUI

struct PetBathView: View {
    var body: some View {
        VStack {
            title
            content
            icon
            button
        }
        .padding()
        .multilineTextAlignment(.center)
        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.98, green: 0.45, blue: 0.63), Color(red: 0.85, green: 0.25, blue: 0.45)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(17)
    }
}

struct PetBath_Previews: PreviewProvider {
    static var previews: some View {
        PetBathView()
    }
}

private extension PetBathView {
    var icon: some View {
        Image ("catHygiene")
    }
    
    var title: some View {
        Text ("Its time to change the litter")
        
            .font(.custom("StayPixel-Regular", size: 32))
            .foregroundColor(.white)
            .padding()
    }
    
    var content: some View {
        Text ("Que tal deixar seu pet limpinho?")
            .font(.custom("StayPixel-Regular", size: 20))
            .foregroundColor(.white)
            .padding(.bottom)
    }
    
        var button: some View {
            VStack {
                NavigationLink(destination: PetManagerCompositionRoot.make()) {
                    Text("Play now")
                }
                .padding()
                .background(Color.white)
                .foregroundColor(Color(red: 0.85, green: 0.25, blue: 0.45))
                .cornerRadius(12)
                .listRowBackground(Color.clear)
                .font(.custom("StayPixel-Regular", size: 24))
                .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 4)
            }
            .padding(.bottom)
            .padding(.top, 20)
        }
    
}

