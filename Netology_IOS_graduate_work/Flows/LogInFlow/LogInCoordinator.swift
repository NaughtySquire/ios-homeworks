//
//  LogInCoordinator.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 02.07.2022.
//

import Foundation
import UIKit

class LogInCoordinator: Coordinator{

    var onFinish: ((UserData, Bool) -> ())?

    private let logInFactory: LogInFactory
    private(set) var rootViewController: UINavigationController?

    init(logInFactory: LogInFactory){
        self.logInFactory = logInFactory
    }

    func start() {
        self.rootViewController = UINavigationController(rootViewController: logInFactory.getLogIn(coordinator: self))
    }

}
