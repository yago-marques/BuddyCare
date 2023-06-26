//
//  ConfigurationsView.swift
//  BuddyCare
//
//  Created by Emilly Maia on 25/06/23.
//

import SwiftUI

struct ConfigurationsView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.init(
                    UIColor(red: 0.98, green: 0.45, blue: 0.63, alpha: 1.00)), .init(
                        UIColor(red: 0.85, green: 0.25, blue: 0.45, alpha: 1.00))],
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack  {
                    NavigationLink(destination: ContentView()) {
                        HStack {
                            Text("change play settings")
                                .padding(.leading, 10)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .padding(.trailing, 10)
                        }
                            .frame(maxWidth: 325, maxHeight: 50)
                            .background(.white)
                            .foregroundColor(.pink)
                            .font(.custom("StayPixel-Regular", size: 20))
                            .cornerRadius(15)
                            .shadow(radius: 1, y: 5)
                            .padding(.top)
                    }
                    NavigationLink(destination: ContentView()) {
                        HStack {
                            Text("change clean settings")
                                .padding(.leading, 10)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .padding(.trailing, 10)
                        }
                            .frame(maxWidth: 325, maxHeight: 50)
                            .background(.white)
                            .foregroundColor(.pink)
                            .font(.custom("StayPixel-Regular", size: 32))
                            .cornerRadius(15)
                            .shadow(radius: 1, y: 5)
                    }
                    Spacer()
                }
                
            }
            .navigationTitle("Settings")
            .foregroundColor(.white)
            .navigationBarTitleDisplayMode(.inline)
        }
  
    }
}
