//
//  PetPlayView.swift
//  BuddyCare
//
//  Created by Emilly Maia on 22/06/23.
//

import SwiftUI

struct PetPlayView: View {
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

struct PetPlayView_Previews: PreviewProvider {
    static var previews: some View {
        PetPlayView()
    }
}

private extension PetPlayView {
    var icon: some View {
        Image ("cat2")
    }
    
    var title: some View {
        Text ("buddy needs attention")
        
            .font(.custom("StayPixel-Regular", size: 32))
            .foregroundColor(.white)
            .padding()
    }
    
    var content: some View {
        Text ("let's go to make your buddy's day happier!")
            .font(.custom("StayPixel-Regular", size: 20))
            .foregroundColor(.white)
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
        }
    
}
