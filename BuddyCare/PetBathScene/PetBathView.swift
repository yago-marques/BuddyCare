//
//  PetBathView.swift
//  BuddyCare
//
//  Created by Emilly Maia on 23/06/23.
//

import SwiftUI

struct PetBathView: View {
    @Binding var isShowing: Bool

    var body: some View {
        VStack {
            title
            content
            icon
            button
            remindlater
        }
        .padding()
        .multilineTextAlignment(.center)
        .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.98, green: 0.45, blue: 0.63), Color(red: 0.85, green: 0.25, blue: 0.45)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(17)
    }
}

struct PetBath_Previews: PreviewProvider {
    static var previews: some View {
        PetBathView(isShowing: .constant(true))
    }
}

private extension PetBathView {
    var icon: some View {
        Image ("catHygiene")
    }
    
    var title: some View {
        Text ("change the litter")
        
            .font(.custom("StayPixel-Regular", size: 32))
            .foregroundColor(.white)
            .padding()
    }
    
    var content: some View {
        Text ("Keeping your pet's space clean is always good!")
            .font(.custom("StayPixel-Regular", size: 17))
            .foregroundColor(.white)
            .padding(.bottom)
    }
    
        var button: some View {
            VStack {
                Button(" Clean up now   ") {
                    isShowing = false
                }
                .padding()
                .background(Color.white)
                .foregroundColor(Color(red: 0.85, green: 0.25, blue: 0.45))
                .cornerRadius(12)
                .listRowBackground(Color.clear)
                .font(.custom("StayPixel-Regular", size: 24))
                .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 4)
            }
            .padding(.top, 20)
        }
    
    var remindlater: some View {
        VStack {
            Button("remind me later") {
                isShowing = false
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

