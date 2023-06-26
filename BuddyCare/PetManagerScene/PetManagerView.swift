
import SwiftUI

struct PetManagerView: View {
    
    private func cleanIcon() -> String {
        var icon: String
        if viewModel.pet?.species.rawValue == "cat" {
            icon = "catHygiene"
        } else {
            icon = "dogHygiene"
        }
        return icon
    }
    
    @ObservedObject var viewModel: PetManagerViewModel
    @State private var showBathView = false
    @State private var showPlayView = false
    @State private var animationDidCalled = false
    @State var petSprite = ""
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
                                width: 300,
                                height: 300
                            )
                            .position(x:proxy.size.width * 0.5,
                                      y:proxy.size.height * 0.623 )
                        Spacer()
                        customTabBar
                            .frame(maxHeight: proxy.size.height * 0.25)
                    }
                }

                .toolbar {
                    ToolbarItem {
                        NavigationLink(destination: ConfigurationsView()) {
                            Image("adjustsButtonIcon")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
                }
                .onAppear {
                    if !animationDidCalled {
                        petIdleAnimation()
                        animationDidCalled = true
                    }

                    Task {
                        try await viewModel.buildLayout()
                    }
                }
            }
        }
        .background(.clear)
        .overlay {
            Group {
                if showPlayView {
                    PetPlayView(viewModel: viewModel, isShowing: $showPlayView)
                        .transition(.scale)
                }
                if showBathView {
                    PetBathView(viewModel: viewModel, isShowing: $showBathView)
                        .transition(.scale)
                }
            }
            .animation(.default, value: showPlayView)
            .animation(.default, value: showBathView)
        }
    }
    
    
    private var customTabBar: some View {
            HStack {
                Spacer()
                CustomButton(title: "ball", isActive: $viewModel.funActionIsActive)
                    .onTapGesture {
                        if viewModel.funActionIsActive {
                            Task {
                                showPlayView = true
                                try await viewModel.markFunActionAsDone()
                            }
                        }
                    }
                Spacer()
                CustomButton(title: cleanIcon(), isActive: $viewModel.bathActionIsActive)
                    .onTapGesture {
                        if viewModel.bathActionIsActive {
                            Task {
                                showBathView = true
                                try await viewModel.markBathActionAsDone()
                            }
                        }
                    }
                Spacer()
            }
            .padding(5)
        }
    
    private var imageView: some View {
        Image(petSprite)
            .resizable()
            .scaledToFit()
            .padding([.bottom], viewModel.isCat() ? 90 : 0)
    }
    
    private var background: some View {
        Image("petHomeBackground")
            .resizable()
    }
}
