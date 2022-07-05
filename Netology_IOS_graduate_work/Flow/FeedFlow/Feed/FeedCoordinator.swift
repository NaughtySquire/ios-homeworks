//
//  FeedCoordinator.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 05.07.2022.
//

import Foundation
import UIKit

class FeedCoordinator: Coordinator{
    private var feedFactory: FeedModulesFactory
    private(set) var rootViewController: UINavigationController?

    init(feedFactory: FeedModulesFactory){
        self.feedFactory = feedFactory
    }

    func start() {
        let vc = feedFactory.getFeed(coordinator: self)
        rootViewController = UINavigationController(rootViewController: vc, tabBarTitle: "Profile", tabBarSystemImageName: "newspaper.circle")
    }
}
