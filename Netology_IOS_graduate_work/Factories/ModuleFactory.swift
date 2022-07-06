//
//  ModuleFactory.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 01.07.2022.
//

import Foundation
import UIKit



class ModuleFactory: LogInFactory,
                     ProfileFactory,
                     FeedFactory{
    // MARK: - main
    func getMain(mainCoordinator: MainCoordinator, userData: UserData) -> UITabBarController{
        let mainController = UITabBarController()
        let profileCoordinator = ProfileCoordinator(profileFactory: self, userData: userData)
        let feedCoordinator = FeedCoordinator(feedFactory: self)
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
    func getLogIn(coordinator: LogInCoordinator) -> LogInViewController {
        let logInViewModel = LogInViewModel()
        logInViewModel.loggedIn = {[weak coordinator] userData, isLoggedIn in
            coordinator?.onFinish?(userData, isLoggedIn)
        }
        let vc = LogInViewController(viewModel: logInViewModel)
        return vc
    }
    // MARK: - profile
    func getProfile(coordinator: ProfileCoordinator, userData: UserData) -> ProfileViewController {
        let vc = ProfileViewController(userData: userData)
        return vc
    }

    func getPhotos(coordinator: ProfileCoordinator) -> PhotosViewController {
        let vc = PhotosViewController()
        vc.navigationItem.title = "Photo Gallery"
        return vc
    }
    // MARK: - feed
    func getFeed(coordinator: FeedCoordinator) -> FeedViewController {
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
