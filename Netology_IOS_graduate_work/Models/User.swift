//
//  User.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 25.06.2022.
//

class User{
    var username: String
    var fullName: String
    var avatarImageName: String
    var statusText: String
    init(username: String, fullName: String, avatarImageName: String, statusText: String) {
        self.username = username
        self.fullName = fullName
        self.avatarImageName = avatarImageName
        self.statusText = statusText    }
}
