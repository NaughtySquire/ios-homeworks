//
//  FetchService.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 01.07.2022.
//

import Foundation

enum FetchError: Error{
    case fetchError
    case noInputData
    case noOutputData
}

class FetchService{
    func fetchUser(username: String, password: String, completion: @escaping (Result<UserData, FetchError>) -> Void){
        DispatchQueue.global().async{
            sleep(2)
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
                completion(.failure(FetchError.fetchError))
            }
        }
    }

    func fetchSoundsUserData(_ username: String?, completion: @escaping ((Result<[SoundData], FetchError>) -> ())){
        guard let username = username else {
            completion(.failure(FetchError.noInputData))
            return
        }
        DispatchQueue.global().sync{
            sleep(1)
            guard let soundsData = usersSoundsData[username] else{
                completion(.failure(FetchError.noOutputData))
                return
            }
            completion(.success(soundsData))

        }
    }

    func fetchSound(artist: String?, name: String?, completion: @escaping ((Result<Sound, FetchError>) -> ())){
        guard let artist = artist, let name = name else {
            completion(.failure(FetchError.noInputData))
            return
        }

        DispatchQueue.global().sync{
            usleep(500_000)
            guard let sound = soundsLibrary[artist]?[name] else{
                completion(.failure(FetchError.noOutputData))
                return
            }
            completion(.success(sound))
        }
    }

}
