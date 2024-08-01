//
//  SplashScreen.swift
//  meditation
//
//  Created by Andrii Zhukevych on 30.07.2024.
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

#Preview {
    SplashScreen()
}
