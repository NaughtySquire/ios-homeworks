//
//  FeedCoordinator.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 05.07.2022.
//

import Foundation
import UIKit

class FeedCoordinator: Coordinator{
    internal var controllerFactory: ModuleFactory
    private(set) var rootViewController: UINavigationController?

    init(_ controllerFactory: ModuleFactory){
        self.controllerFactory = controllerFactory
    }

    func start() {
        goToFeedVC()
    }

    private func goToFeedVC(){
        let vc = controllerFactory.getFeed()
        rootViewController = UINavigationController(rootViewController: vc,
                                                    tabBarTitle: "Feed",
                                                    tabBarSystemImageName: "newspaper.circle")
    }
}
