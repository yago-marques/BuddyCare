//
//  PetPlayView.swift
//  BuddyCare
//
//  Created by Emilly Maia on 22/06/23.
//

import SwiftUI

struct PetPlayView: View {
    
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


private extension PetPlayView {
    var icon: some View {
        Image (viewModel.pet?.avatar ?? "BlackDog")
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
                Button(" Let's start play") {
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
