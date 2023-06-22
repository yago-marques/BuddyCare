import SwiftUI

@main
struct BuddyCareApp: App {
    
    @StateObject var viewModel = OnboardingModel()
    
    var body: some Scene {
        WindowGroup {
            if OnboardingModel().isFirstAccess {
                PetRegisterName()
                    .environmentObject(viewModel)
            } else {
                PetManagerCompositionRoot.make()
            }
        }
    }
}
