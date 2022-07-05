//
//  CoordinatorProtocol.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 02.07.2022.
//

import Foundation
import UIKit

class ChildCoordinator{
    enum Controllers{}
    private var navigationVC: UINavigationController = UINavigationController()
    func push(viewController: UIViewController, c: enum) {
        navigationVC.pushViewController(viewController, animated: true)
    }

    func pop() {
        navigationVC.popViewController(animated: true)
    }

    func popToRoot() {
        navigationVC.popToRootViewController(animated: true)
    }
}
