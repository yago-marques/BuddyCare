
import SwiftUI

struct PetManagerView: View {
    @ObservedObject var viewModel: PetManagerViewModel
  
    @State private var showBathView = false
    @State private var showPlayView = false
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
                            .onAppear {
                                petIdleAnimation()
                            }
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
        .overlay {
            Group {
                if showPlayView {
                    PetPlayView(isShowing: $showPlayView)
                        .transition(.scale)
                }
                if showBathView {
                    PetBathView(isShowing: $showBathView)
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
                                try await viewModel.registerFunAction()
                                showPlayView = true
                            }
                        }
                    }
                Spacer()
                CustomButton(title: "catHygiene", isActive: $viewModel.bathActionIsActive)
                    .onTapGesture {
                        if viewModel.bathActionIsActive {
                            Task {
                                try await viewModel.registerBathAction()
                                showBathView = true
                                
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
    }
    
    private var background: some View {
        Image("petHomeBackground")
            .resizable()
    }
}
