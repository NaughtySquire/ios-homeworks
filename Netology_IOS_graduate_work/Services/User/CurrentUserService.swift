//
//  CurrentUserService.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 25.06.2022.
//

class CurrentUserService: UserService{
    private var user = User(username: "wolk", fullName: "Мудрый волк", avatarImageName: "wolk", statusText: "Сделал дело - дело сделано")
    func getUser(username: String) -> User {
        return user.username == username ? user : User(username: "", fullName: "", avatarImageName: "", statusText: "")
    }

}
