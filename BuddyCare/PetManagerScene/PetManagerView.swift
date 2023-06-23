
import SwiftUI

struct PetManagerView: View {
    @ObservedObject var viewModel: PetManagerViewModel
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { proxy in
                ZStack {
                    background
                        .ignoresSafeArea()

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
                            Image("adjustsButtonIcon")
                                .resizable()
                                .frame(width: 50, height: 50)
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
        .background(.clear)
    }
    
    
    private var customTabBar: some View {
        HStack {
            Spacer()
            CustomButton(title: "ball", isActive: $viewModel.funActionIsActive, destination: PetPlayView())
                .onTapGesture {
                    if viewModel.funActionIsActive {
                        Task {
                            try await viewModel.registerFunAction()
                        }
                    }
                }
            Spacer()
            CustomButton(title: "catHygiene", isActive: $viewModel.bathActionIsActive, destination: PetBathView())
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
        Image("cat1")
            .resizable()
            .scaledToFit()
    }
    
    private var background: some View {
        Image("petHomeBackground")
            .resizable()
    }
}
