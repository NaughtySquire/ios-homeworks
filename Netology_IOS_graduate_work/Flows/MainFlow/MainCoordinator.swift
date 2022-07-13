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
    private weak var mainFactory: ModuleFactory?
    var childCoordinators = [Coordinator]()
    var userData: UserData

    init(mainFactory: ModuleFactory, userData: UserData){
        self.mainFactory = mainFactory
        self.userData = userData
    }

    func start() {
        rootViewController = mainFactory?.getMain(mainCoordinator: self, userData: userData)
    }


}
