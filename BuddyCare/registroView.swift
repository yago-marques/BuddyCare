//
//  registroView.swift
//  BuddyCare
//
//  Created by Mateus Calisto on 13/06/23.
//

import Foundation
import SwiftUI

struct registroView: View {
    
    @StateObject private var viewModel = NumberPickerViewModel()
    var body: some View {
        VStack {
            Text("Higiene")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
            Form {
//                Section(header: Text("Selecione um número")) {
                    Picker("A cada quantos dias?", selection: $viewModel.selectedNumber) {
                        ForEach(viewModel.numbers, id: \.self) { number in
                            Text("\(number)").tag(number)
                        }
//                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                    .scrollContentBackground(.hidden)
                }
                
            }.scrollContentBackground(.hidden)
        }
        
        
                }
        
    }


//struct registroView_Previews: PreviewProvider {
//    static var previews: some View {
//        registroView()
//    }
//}

