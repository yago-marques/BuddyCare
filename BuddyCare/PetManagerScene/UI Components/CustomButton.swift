//
//  CustomButton.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            Image(title)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(isActive ? .white : .init(red: 0.88, green: 0.88, blue: 0.88))
                .cornerRadius(12)
                .padding(20)
                .opacity(isActive ? 1 : 0.8)
        }
        .aspectRatio(contentMode: .fill)
    }
}
