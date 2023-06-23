
import SwiftUI

struct PetManagerView: View {
    @ObservedObject var viewModel: PetManagerViewModel
    @State var petSprite: String = ""
    
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
                            .position(
                                x:proxy.size.width * 0.5,
                                y:proxy.size.height * 0.6)
                            .onAppear() {
                                petAnimationTimer()
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
        Image(petSprite)
            .resizable()
            .scaledToFit()
    }
    
    private var background: some View {
        Image("petHomeBackground")
            .resizable()
    }

    func petAnimationTimer() {
        var index = 1
          let timer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { (Timer) in

              petSprite = "\(viewModel.pet?.avatar)\(index)"

                index += 1

                if (index > 5){
                    index = 1

            }
        }
    }
}
