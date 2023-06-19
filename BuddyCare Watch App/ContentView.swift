//
//  ContentView.swift
//  BuddyCare Watch App
//
//  Created by Yago Marques on 12/06/23.
//

import SwiftUI

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
            checkForNotificationAuthorization()
            dispatchBathNotification(date: Date.now, identifier: "sdasdas", frequency: 0)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
