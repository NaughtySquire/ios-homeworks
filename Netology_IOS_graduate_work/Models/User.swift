//
//  User.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 01.07.2022.
//

import Foundation

class User: Equatable{
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.username == rhs.username && lhs.password == rhs.password
    }

    var username = "wolk"
    var password = "Пароль"


    init(username: String, password: String){
        self.username = username
        self.password = password
    }
}

