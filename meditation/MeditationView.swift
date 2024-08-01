//
//  MeditationView.swift
//  meditation
//
//  Created by Andrii Zhukevych on 30.07.2024.
//

import SwiftUI
import AVFoundation

// let defaultTime = 5 * 60 // 5 minutes in seconds
let defaultTime = 30 // shorter period for debugging

struct MeditationView: View {
    private var showRemainingTime = true
    @State private var isMeditationActive = false
    @State private var remainingTime = defaultTime
    @State private var timer: Timer?
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        VStack {            
            if showRemainingTime {
                VStack {
                    Text("Time Remaining:")
                        .font(.title)
                        .padding()
                    Text("\(remainingTime / 60) min \(remainingTime % 60) sec")
                        .font(.title)
                        .padding()
                }
            }
            
            if !isMeditationActive {
                HStack {
                    Button(action: startMeditation) {
                        Text("Start")
                            .font(.title)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: resetTime) {
                        Text("Reset")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }   
                }
            } else {
                Button(action: stopMeditation) {
                    Text("Stop Meditation")
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .onDisappear(perform: stopMeditation) // Ensure timer and audio stop when view disappears
    }

    private func startMeditation() {
        isMeditationActive = true
        startTimer()
        playAudio()
    }

    private func stopMeditation() {
        isMeditationActive = false
        stopTimer()
        stopAudio()
    }

    private func resetTime() {
        remainingTime = defaultTime
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                self.stopMeditation()
                self.onMeditationDidFinish()
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func playAudio() {
        guard let url = Bundle.main.url(forResource: "beach", withExtension: "mp3") else {
            print("Audio file not found.")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Audio playback failed: \(error)")
        }
    }

    private func stopAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
    }

    private func onMeditationDidFinish() {
        // TODO: notify the user with system sound that meditation has finished
        print("Meditation session is over! 🚀")
    }
}

#Preview {
    MeditationView()
}
