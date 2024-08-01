//
//  MeditationData.swift
//  meditation
//
//  Created by Andrii Zhukevych on 30.07.2024.
//

import Foundation

struct MeditationType: Identifiable {
    var id: Int
    var title: String
    var image: String // Assumed to be the name of the image file
    var audio: String // Assumed to be the name of the audio file
}
