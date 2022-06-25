//
//  TestUserService.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 25.06.2022.
//

class TestUserService: UserService{
    private let user = User(username: "testUsername", fullName: "testFullName", avatarImageName: "", statusText: "testStatusText")
    func getUser(username: String) -> User {
        user
    }
}
