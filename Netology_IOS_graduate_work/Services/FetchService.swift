//
//  FetchService.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 01.07.2022.
//

import Foundation

enum FetchError: Error{
    case authError
    case connectionError
}

class FetchService{
    func getUser(username: String, password: String, completion: @escaping (Result<UserData, FetchError>) -> Void){
        DispatchQueue.global().async{
            sleep(2)
            /// Иммитация ошибки плохого соединения с сетью
            guard [true, true, false].randomElement()! else {
//                completion(.failure(FetchError.connectionError))
                preconditionFailure("Интернет недоступен")
                return
            }
            do {
                try completion(.success(self.fetchUser(username, password)))
            }catch{
                completion(.failure(FetchError.authError))
            }
        }
    }
    private func fetchUser(_ username: String, _ password: String) throws -> UserData{
        if username == "wolk" && password == "Пароль" {
            return UserData(name: "Мудрый",
                            surname: "Волк",
                            status: "Сделал дело - дело сделано",
                            avatarImageName: "wolk",
                            userPosts: posts)
        }else{
            throw FetchError.authError
        }
    }
}
