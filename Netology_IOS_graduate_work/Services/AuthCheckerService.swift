//
//  authCheckerService.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 26.06.2022.
//

import Foundation

protocol authServiceCheckerProtocol{
    func checkLoginAndPassword(login: String, password: String) -> Bool
}


class AuthServiceChecker: authServiceCheckerProtocol{
    ///singletone
    static let shared = AuthServiceChecker()
    //MARK: - data
    private let login = "wolk"
    private let password = "qwerty1234"

    private init() {}
    /// protocol implementation
    func checkLoginAndPassword(login: String, password: String) -> Bool {
        return self.login.hashValue == login.hashValue && self.password.hashValue == password.hashValue
    }

}
