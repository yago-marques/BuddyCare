import SwiftUI

@main
struct BuddyCareApp: App {
    
    var body: some Scene {
        WindowGroup {
            if NumberPickerViewModel().isFirstAccess {
                RegisterPetView()
            } else {
                PetManagerCompositionRoot.make()
            }
        }
    }
}
