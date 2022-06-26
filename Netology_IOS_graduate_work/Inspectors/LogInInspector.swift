//
//  LogInInspector.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 26.06.2022.
//

import Foundation

class LogInInspector: LogInViewControllerDelegate{
    func checkLogIn(login: String, password: String) -> Bool {
        AuthServiceChecker.shared.checkLoginAndPassword(login: login, password: password)
    }
}
