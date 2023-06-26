//
//  PetBathView.swift
//  BuddyCare
//
//  Created by Emilly Maia on 23/06/23.
//

import SwiftUI

struct PetBathView: View {
    
    private func cleanIcon() -> String {
        var icon: String
        if viewModel.pet?.species.rawValue == "cat" {
            icon = "catHygiene"
        } else {
            icon = "dogHygiene"
        }
        return icon
    }
    
    private func cleanText() -> String {
        var text: String
        if viewModel.pet?.species.rawValue == "cat" {
            text = "Change the litter"
        } else {
            text = "Time to bath!"
        }
        return text
    }
    
    @ObservedObject var viewModel: PetManagerViewModel
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

private extension PetBathView {
    var icon: some View {
        Image (cleanIcon())
    }
    
    var title: some View {
        Text (cleanText())
        
            .font(.custom("StayPixel-Regular", size: 32))
            .foregroundColor(.white)
            .padding()
    }
    
    var content: some View {
        Text ("Taking care of your pet's hygiene is always good!")
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

