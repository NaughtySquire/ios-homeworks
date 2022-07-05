//
//  MainCoordinator.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 01.07.2022.
//

import Foundation
import UIKit


class AppCoordinator: Coordinator{

    // MARK: - properties

    var window: UIWindow
    private let moduleFactory = ModuleFactory()
    private var childCoordinators = [Coordinator]()
    private var isLoggedIn = false
    private lazy var userData = UserData(name: "test",
                                         surname: "test",
                                         status: "test",
                                         avatarImageName: "wolk",
                                         userPosts: posts)

    // MARK: - init

    init(window: UIWindow){
        self.window = window
    }

    // MARK: - functions

    func start(){
        if isLoggedIn{
            goToMainFlow()
        }else{
            goToLogInFlow()
        }
        window.makeKeyAndVisible()
    }

    private func goToMainFlow(){
        let mainCoordinator = MainCoordinator(mainFactory: moduleFactory, userData: userData)
        self.childCoordinators.removeAll()
        self.childCoordinators = [mainCoordinator]
        mainCoordinator.start()
        window.rootViewController = mainCoordinator.rootViewController
    }

    private func goToLogInFlow(){
        let logInCoordinator = LogInCoordinator(logInFactory: moduleFactory)
        self.childCoordinators = [logInCoordinator]
        logInCoordinator.onFinish = {[weak self] userData, isLoggedIn in
            self?.userData = userData
            self?.isLoggedIn = isLoggedIn
            self?.goToMainFlow()
        }
        logInCoordinator.start()
        window.rootViewController = logInCoordinator.rootViewController!
    }

}

