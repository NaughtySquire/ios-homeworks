//
//  Sound.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 19.07.2022.
//

import Foundation

struct Sound{
    var url: String
    var fileExtension: String
}

let soundsLibrary: [String: [String: Sound]] =  [
    "Queen": [
        "Another One Bites The Dust": Sound(url: "Queen - Another One Bites The Dust",
                                            fileExtension: ".mp3"),

        "Dont Stop Me Now": Sound(url: "Queen - Dont Stop Me Now",
                                          fileExtension: ".mp3"),

        "I Want To Break Free": Sound(url: "Queen - I Want To Break Free",
                                      fileExtension: ".mp3"),

        "The Show Must Go On": Sound(url: "Queen - The Show Must Go On",
                                     fileExtension: ".mp3"),

        "We Will Rock You": Sound(url: "Queen - We Will Rock You",
                                  fileExtension: ".mp3"),

        "Under Pressure": Sound(url: "Queen David Bowie - Under Pressure",
                                fileExtension: ".mp3"),
    ]
]
