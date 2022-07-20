//
//  Sounds.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 19.07.2022.
//

import Foundation

struct SoundData {
    var artist: String
    var name: String
}

let usersSoundsData: [String: [SoundData]] = [
    "wolk": [
        SoundData(artist: "Queen",
                  name: "Another One Bites The Dust"),

        SoundData(artist: "Queen",
                  name: "Dont Stop Me Now"),

        SoundData(artist: "Queen",
                  name: "I Want To Break Free"),

        SoundData(artist: "Queen",
                  name: "The Show Must Go On"),

        SoundData(artist: "Queen",
                  name: "We Will Rock You"),

        SoundData(artist: "Queen",
                  name: "Under Pressure"),
    ]
]


