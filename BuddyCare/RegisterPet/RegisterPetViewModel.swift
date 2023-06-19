import Foundation

class RegisterPetViewModel: ObservableObject {
    @Published var avatars: [String: [String]]
    
    init() {
        avatars = [
            "cat": ["cat1", "cat2", "cat3"],
            "dog": ["dog1", "dog2", "dog3"]
        ]
    }
}
