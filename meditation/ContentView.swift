//
//  ContentView.swift
//  meditation
//
//  Created by Andrii Zhukevych on 29.07.2024.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false

    var body: some View {
        VStack {
            if isActive {
                // Main Content View
                ContentView()
            } else {
                // Splash Screen Content
                Image("simple_meditation_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
            }
        }
        .transition(.opacity)
    }
}


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
            
            // Other UI components
            VStack {
                Spacer()
                Text("Cherry-Blossom Meditation")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()

                // Your additional UI elements here...
            }.padding()
        }
    }
}

#Preview {
    ContentView()
}
