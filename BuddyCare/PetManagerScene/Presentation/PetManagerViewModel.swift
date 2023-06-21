//
//  PetManagerViewModel.swift
//  BuddyCare
//
//  Created by Yago Marques on 14/06/23.
//

import Foundation

typealias PetManagerUseCases = FetchPet & BathManagement & FunManagement

final class PetManagerViewModel: ObservableObject {
    @Published var pet: DisplayedPet? = nil
    @Published var funActionIsActive = false
    @Published var bathActionIsActive = false
    private var systemId: String = ""

    private let useCases: PetManagerUseCases

    init(useCases: PetManagerUseCases) {
        self.useCases = useCases
    }

    func buildLayout() async throws {
        self.systemId = try CoreDataService.shared.getId()
        try await fetchPet()
        try await useCases.registerFunActionIfNeeded(id: systemId)
        try await useCases.registerBathActionIfNeeded(id: systemId)
        try await verifyNeededActions()
    }

    func registerBathAction() async throws {
//        try await useCases.registerBathAction(at: Date())
    }

    func registerFunAction() async throws {
//        try await useCases.registerFunAction(at: Date(), id: "")
    }

}

private extension PetManagerViewModel {
    @MainActor
    func fetchPet() async throws {
        self.pet = try await useCases.fetchPet()
    }

    @MainActor
    func verifyNeededActions() async throws {
        self.funActionIsActive = try await useCases.funActionIsNeeded(id: systemId)
        self.bathActionIsActive = try await useCases.bathActionIsNeeded(id: systemId)
    }
}
