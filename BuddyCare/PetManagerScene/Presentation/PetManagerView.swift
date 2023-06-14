//
//  PetManagerView.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import SwiftUI

struct PetManagerView: View {
    @ObservedObject var viewModel: PetManagerViewModel

    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer()
                    imageView
                        .frame(
                            width: proxy.size.width,
                            height: proxy.size.width
                        )
                    Spacer()
                    customTabBar
                        .frame(maxHeight: proxy.size.height * 0.25)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        print("ok")
                    }, label: {
                        Image(systemName: "pencil")
                    })
                }
            }
            .onAppear {
                Task {
                    try await viewModel.buildLayout()
                }
            }
        }
    }

    private var customTabBar: some View {
        HStack {
            Spacer()
            CustomButton(title: "Lazer", isActive: $viewModel.funActionIsActive)
                .onTapGesture {
                    if viewModel.funActionIsActive {
                        Task {
                            try await viewModel.registerFunAction()
                        }
                    }
                }
            Spacer()
            CustomButton(title: "Higiene", isActive: $viewModel.bathActionIsActive)
                .onTapGesture {
                    if viewModel.bathActionIsActive {
                        Task {
                            try await viewModel.registerBathAction()
                        }
                    }
                }
            Spacer()
        }
        .padding(5)
    }

    private var imageView: some View {
        Image(systemName: "..")
            .resizable()
            .scaledToFit()
            .background(.gray)
    }
}
