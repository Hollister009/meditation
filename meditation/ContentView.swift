//
//  ContentView.swift
//  meditation
//
//  Created by Andrii Zhukevych on 29.07.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(meditations) { meditation in
                NavigationLink(destination: MeditationView()) {                    
                    HStack {
                        Image(meditation.image)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .shadow(radius: 5)

                        Spacer()

                        Text(meditation.title)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .navigationTitle("Meditations")
    }
}

#Preview {
    ContentView()
}
