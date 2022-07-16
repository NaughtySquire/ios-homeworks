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

    private var window: UIWindow
    var controllerFactory = ModuleFactory()
    private var childCoordinators = [any Coordinator]()
    private var isLoggedIn = false
    
    // MARK: - init

    init(window: UIWindow){
        self.window = window
    }

    // MARK: - functions

    func start(){
        if isLoggedIn{
            goToMainFlow(userData: UserData(name: "test",
                                            surname: "test",
                                            status: "test",
                                            avatarImageName: "wolk",
                                            userPosts: posts))
        }else{
            goToLogInFlow()
        }
        window.makeKeyAndVisible()
    }

    private func goToMainFlow(userData: UserData){
        let mainCoordinator = MainCoordinator(controllerFactory, userData)
        self.childCoordinators = [mainCoordinator]
        mainCoordinator.start()
        window.rootViewController = mainCoordinator.rootViewController
    }

    private func goToLogInFlow(){
        let logInCoordinator = LogInCoordinator(controllerFactory)
        self.childCoordinators = [logInCoordinator]
        logInCoordinator.onFinish = {[weak self] userData, isLoggedIn in
            self?.isLoggedIn = isLoggedIn
            self?.goToMainFlow(userData: userData)
        }
        logInCoordinator.start()
        window.rootViewController = logInCoordinator.rootViewController!
    }

}

