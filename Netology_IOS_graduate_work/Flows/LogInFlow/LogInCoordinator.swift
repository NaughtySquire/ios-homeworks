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
    private weak var logInFactory: ModuleFactory?
    private(set) var rootViewController: UINavigationController?

    init(logInFactory: ModuleFactory){
        self.logInFactory = logInFactory
    }

    func start() {
        goToLogIn()
    }

    func goToLogIn(){
        let viewModel = LogInViewModel()
        viewModel.loggedIn = {[weak self] userData, isLoggedIn in
            self?.onFinish?(userData, isLoggedIn)
        }
        let viewController = (logInFactory?.getLogIn(viewModel: viewModel))!
        self.rootViewController = UINavigationController(rootViewController: viewController)
        rootViewController?.navigationBar.isHidden = true
    }
}
