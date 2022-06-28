//
//  User.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 28.06.2022.
//

import Foundation

class User{
    private let password = "Пароль"
    private var isCorrectPassword = false{
        willSet{
            NotificationCenter.default.post(name: .init(rawValue: "passwordWasChecked"), object: nil, userInfo: ["isCorrectPassword": newValue])
        }
    }
    func check(word: String){
        isCorrectPassword = password.hashValue == word.hashValue
    }
}
