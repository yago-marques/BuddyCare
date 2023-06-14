//
//  ContentView.swift
//  BuddyCare
//
//  Created by Yago Marques on 12/06/23.
//

import SwiftUI
import CloudKit

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            Task{
                do {
//                    try await CloudKitService.iCloud.createPet(.init(name: "Bambino", gender: "Male", species: "Dog", avatar: "AnimatedDog"))

                    let pets = try await CloudKitService.shared.fetchPets()

//                    try await CloudKitService.iCloud.updatePet(of: pets[1].id, new: .init(name: "Bambina", gender: "Female", species: "Dog", avatar: "AnimatedDog"))

                    for pet in pets {
                        try await CloudKitService.shared.createFunSchedule(.init(petId: pet.id, frequency: 3, times: [Date()]))
                        try await CloudKitService.shared.createBathSchedule(.init(petId: pet.id, frequency: 4, times: [Date(), Date()]))
                    }

//                    print(pets)

                } catch {
                    print(error)
                }
                    
            }

            checkForNotificationAuthorization()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
