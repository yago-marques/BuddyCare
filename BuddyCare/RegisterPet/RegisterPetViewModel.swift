import Foundation

final class RegisterPetViewModel: ObservableObject {
    private let iCloud = CloudKitService.shared
    private let localStorage = CoreDataService.shared
    @Published var avatars: [String: [String]]
    @Published var navigateToCleaner: Bool = false
    @Published var buttonIsActive: Bool = true
    @Published var petId = String()
    
    init() {
        avatars = [
            "cat": ["cat1", "cat2", "cat3"],
            "dog": ["dog1", "dog2", "dog3"]
        ]
    }

    @MainActor
    public func nextButtonHandler(with pet: Pet) async throws {
        disableNextButton()
        try await registerNewPetAndGiveId(pet)
        navigateToRegisterSchedulesView()
    }

}

private extension RegisterPetViewModel {
    @MainActor
    func registerNewPetAndGiveId(_ pet: Pet) async throws  {
        var pet = pet
        self.petId = try await iCloud.createPet(pet)
        pet.id = self.petId
        _ = try await localStorage.createPet(pet)
    }

    @MainActor
    func navigateToRegisterSchedulesView() {
        self.navigateToCleaner = true
    }

    @MainActor
    func disableNextButton() {
        self.buttonIsActive = false
    }
}
