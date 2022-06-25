//
//  UserServiceProtocol.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 25.06.2022.
//

protocol UserService{
    func getUser(username: String) -> User
}
