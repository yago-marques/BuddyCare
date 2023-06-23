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
        RoundedRectangle(cornerRadius: 10)
            .fill(isActive ? .white : .init(red: 0.88, green: 0.88, blue: 0.88))
            .padding(20)
            .overlay {
                Image(title)
                    .foregroundColor(.white)
            }
            .opacity(isActive ? 1 : 0.8)
    }
}
