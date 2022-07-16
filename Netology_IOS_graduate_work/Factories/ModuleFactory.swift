//
//  ModuleFactory.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 01.07.2022.
//

import Foundation
import UIKit



class ModuleFactory{
    enum ControllerName{
        case logIn
        case profile
        case photos
        case feed
        case post
        case info
    }
    // MARK: - main
    func getMain(mainCoordinator: MainCoordinator, userData: UserData) -> UITabBarController{
        let mainController = UITabBarController()
        let profileCoordinator = ProfileCoordinator(self, userData)
        let feedCoordinator = FeedCoordinator(self)
        mainCoordinator.childCoordinators = [profileCoordinator, feedCoordinator]
        profileCoordinator.start()
        feedCoordinator.start()
        mainController.viewControllers = [
            profileCoordinator.rootViewController!,
            feedCoordinator.rootViewController!
        ]
        return mainController
    }

    // MARK: - logIn
    func getLogIn(viewModel: LogInViewModel) -> UIViewController {
        let vc = LogInViewController(viewModel: viewModel)
        vc.view.backgroundColor = .white
        vc.addSubviews()
        vc.addConstraints()
        vc.setupViewModel()
        return vc
    }
    // MARK: - profile
    func getProfile(viewModel: ProfileViewModel) -> UIViewController {
        let vc = ProfileViewController(viewModel: viewModel)
        vc.view.backgroundColor = .systemGray6
        vc.addSubviews()
        vc.addConstraints()
        vc.setupGesture()
        vc.setupViewModel()
        return vc
    }

    func getPhotos() -> UIViewController {
        let vc = PhotosViewController()
        vc.navigationItem.title = "Photo Gallery"
        return vc
    }
    // MARK: - feed
    func getFeed(coordinator: FeedCoordinator) -> UIViewController {
        let vc = FeedViewController()
        return vc
    }

    func getPost(coordinator: FeedCoordinator) -> PostViewController {
        let vc = PostViewController()
        vc.post = Post(title: "Новый пост")
        return vc

    }

    func getInfo(coordinator: FeedCoordinator) -> InfoViewController {
        let vc = InfoViewController()
        return vc
    }

}
