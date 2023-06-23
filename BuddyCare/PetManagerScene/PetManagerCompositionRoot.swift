//
//  PetManagerCompositionRoot.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import SwiftUI

enum PetManagerCompositionRoot {
    static func make() -> some View {
        let cloudKitUseCases = SynchedCloudKitPetManager()
        let viewModel = PetManagerViewModel(useCases: cloudKitUseCases)
        let view = PetManagerView(viewModel: viewModel)

        return view
    }
}
