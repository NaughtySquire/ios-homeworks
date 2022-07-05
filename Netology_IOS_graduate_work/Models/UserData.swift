//
//  UserData.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 05.07.2022.
//

import Foundation

class UserData{
    var name: String
    var surname: String
    var status: String
    var avatarImageName: String
    var userPosts: [Post]


    init(name: String, surname: String, status: String, avatarImageName: String, userPosts: [Post]){
        self.name = name
        self.surname = surname
        self.status = status
        self.avatarImageName = avatarImageName
        self.userPosts = userPosts
    }
}
