//
//  FeedCoordinator.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 05.07.2022.
//

import Foundation
import UIKit

class FeedCoordinator: Coordinator{
    private var feedFactory: FeedFactory
    private(set) var rootViewController: UINavigationController?

    init(feedFactory: FeedFactory){
        self.feedFactory = feedFactory
    }

    func start() {
        goToFeedVC()
    }

    private func goToFeedVC(){
        let vc = feedFactory.getFeed(coordinator: self)
        rootViewController = UINavigationController(rootViewController: vc,
                                                    tabBarTitle: "Feed",
                                                    tabBarSystemImageName: "newspaper.circle")
    }
}
