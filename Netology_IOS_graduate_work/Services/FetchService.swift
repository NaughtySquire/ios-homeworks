//
//  FetchService.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 01.07.2022.
//

import Foundation

enum FetchErrors: Error{
    case fetchError
}

class FetchService{
    func fetchUser(username: String, password: String, completion: @escaping (Result<UserData, Error>) -> Void){
        DispatchQueue.global().sync{
            sleep(1)
            if username == "wolk" && password == "Пароль" {
            completion(.success(UserData(name: "Мудрый",
                                         surname: "Волк",
                                         status: "Сделал дело - дело сделано",
                                         avatarImageName: "wolk",
                                         userPosts: posts
                                        )
                                )
                       )
            }else{
                completion(.failure(FetchErrors.fetchError))
            }
        }
    }
}
