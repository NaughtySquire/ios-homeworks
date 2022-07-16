//
//  MainCoordinator.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 05.07.2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator{

    private(set) var rootViewController: UITabBarController?
    internal var controllerFactory: ModuleFactory
    var childCoordinators = [Coordinator]()
    var userData: UserData

    init(_ controllerFactory: ModuleFactory, _ userData: UserData){
        self.controllerFactory = controllerFactory
        self.userData = userData
    }

    func start() {
        rootViewController = controllerFactory.getMain(mainCoordinator: self, userData: userData)
    }


}
