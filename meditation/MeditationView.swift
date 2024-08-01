//
//  MeditationView.swift
//  meditation
//
//  Created by Andrii Zhukevych on 30.07.2024.
//

import SwiftUI
import AVFoundation
import AudioToolbox

 let DEFAULT_TIME = 5 * 60 // 5 minutes in seconds
// let DEFAULT_TIME = 5  // shorter period for debugging
// Use one of the predefined system sound IDs
let SOUND_ID: SystemSoundID = 1008

struct MeditationView: View {
    private var showRemainingTime = true
    @State private var isMeditationActive = false
    @State private var remainingTime = DEFAULT_TIME
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
        .onAppear {
            self.playSystemSound() // Just for testing!
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            self.stopMeditation() // Ensure timer and audio stop when view disappears
            UIApplication.shared.isIdleTimerDisabled = false
        }
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
        remainingTime = DEFAULT_TIME
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
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch {
            print("Audio playback failed: \(error)")
        }
    }

    private func stopAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
    }

    private func playSystemSound() {
        AudioServicesPlaySystemSound(SOUND_ID)
    }

    private func onMeditationDidFinish() {
        playSystemSound()
        print("Meditation session is over! 🚀")
    }
}

#Preview {
    MeditationView()
}
