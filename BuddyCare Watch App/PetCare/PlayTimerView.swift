//
//  PlayTimerView.swift
//  BuddyCare Watch App
//
//  Created by Emilly Maia on 21/06/23.
//

import SwiftUI

struct PlayTimerView: View {
    
    @State var timeRemaining = 1200
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.98, green: 0.45, blue: 0.63), Color(red: 0.85, green: 0.25, blue: 0.45)]), startPoint: .top, endPoint: .bottom)
                 .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Text("Play Time")
                    .padding(.bottom)
                    .foregroundColor(.white)
                    .font(.custom("StayPixel-Regular", size: 24))
                
                Text(timeString(from: timeRemaining))
                    .font(.system(size: 70, design: .rounded))
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        }
                    }
                
                VStack {
                    Button("End activity") {
                        
                    }
                    .background(Color.white)
                    .foregroundColor(Color(red: 0.85, green: 0.25, blue: 0.45))
                    .cornerRadius(12)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .padding(.top)
                    .font(.custom("StayPixel-Regular", size: 17))
                    .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 4)
                                        
                }
            }
        }
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}


struct PlayTimerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayTimerView()
    }
}
