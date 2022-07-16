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
    var controllerFactory: ModuleFactory
    private(set) var rootViewController: UINavigationController?

    init(_ controllerFactory: ModuleFactory){
        self.controllerFactory = controllerFactory
    }

    func start() {
        goToLogIn()
    }

    func goToLogIn(){
        let viewModel = LogInViewModel()
        viewModel.loggedIn = {[weak self] userData, isLoggedIn in
            self?.onFinish?(userData, isLoggedIn)
        }
        let viewController = controllerFactory.getLogIn(viewModel: viewModel)
        self.rootViewController = UINavigationController(rootViewController: viewController)
        rootViewController?.navigationBar.isHidden = true
    }
}
