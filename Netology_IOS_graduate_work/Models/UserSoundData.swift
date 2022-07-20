//
//  Sounds.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 19.07.2022.
//

import Foundation

struct UserSoundData {
    var artist: String
    var name: String
}

let usersSoundsData: [String: [UserSoundData]] = [
    "wolk": [
        UserSoundData(artist: "Queen",
                  name: "Another One Bites The Dust"),

        UserSoundData(artist: "Queen",
                  name: "Dont Stop Me Now"),

        UserSoundData(artist: "Queen",
                  name: "I Want To Break Free"),

        UserSoundData(artist: "Queen",
                  name: "The Show Must Go On"),

        UserSoundData(artist: "Queen",
                  name: "We Will Rock You"),

        UserSoundData(artist: "Queen David Bowie",
                  name: "Under Pressure"),
    ]
]


