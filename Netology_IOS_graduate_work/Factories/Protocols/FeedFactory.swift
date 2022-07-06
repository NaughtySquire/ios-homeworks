//
//  PostFactory.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 05.07.2022.
//

import Foundation
import UIKit

protocol FeedFactory{

    func getFeed(coordinator: FeedCoordinator) -> FeedViewController

    func getPost(coordinator: FeedCoordinator) -> PostViewController

    func getInfo(coordinator: FeedCoordinator) -> InfoViewController
}
