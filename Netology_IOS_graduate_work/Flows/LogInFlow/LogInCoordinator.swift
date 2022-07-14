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
    private weak var logInFactory: LogInFactory?
    private(set) var rootViewController: UINavigationController?

    init(logInFactory: LogInFactory){
        self.logInFactory = logInFactory
    }

    func start() {
        goToLogIn()
    }

    private func goToLogIn(){
        let viewModel = LogInViewModel()
        viewModel.loggedIn = {[weak self] userData, isLoggedIn in
            self?.onFinish?(userData, isLoggedIn)
        }
        viewModel.showAllert = {[weak self] message in
            self?.showAllert(message: message)
        }
        let viewController = (logInFactory?.getLogIn(viewModel: viewModel))!
        self.rootViewController = UINavigationController(rootViewController: viewController)
        rootViewController?.navigationBar.isHidden = true
    }

    private func showAllert(message: String){
        let allert = UIAlertController(title: "Что-то пошло не так",
                                       message: message,
                                       preferredStyle: .alert)
        allert.addAction(.init(title: "Ок", style: .default))
        rootViewController?.present(allert, animated: true)
    }
}
