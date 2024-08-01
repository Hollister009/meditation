//
//  ContentView.swift
//  meditation
//
//  Created by Andrii Zhukevych on 29.07.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // Background Image
            Image("sakura_beach_ocean_mountain")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.height)
                .clipped()
                .edgesIgnoringSafeArea(.all)
            
            // Gradient Overlay for Glass Effect
            LinearGradient(
                gradient: Gradient(colors: [Color.white.opacity(0.5), Color.white.opacity(0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            .blur(radius: 10)
            
            MeditationView()
        }
    }
}

#Preview {
    ContentView()
}
