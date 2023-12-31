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
        .padding(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
