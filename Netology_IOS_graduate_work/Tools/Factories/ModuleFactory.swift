//
//  ModuleFactory.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 01.07.2022.
//

import Foundation
import UIKit



class ModuleFactory{

    // MARK: - main
    func getMain(mainCoordinator: MainCoordinator, userData: UserData) -> UITabBarController{
        let profileCoordinator = ProfileCoordinator(self, userData)
        let feedCoordinator = FeedCoordinator(self)
        profileCoordinator.start()
        feedCoordinator.start()
        
        mainCoordinator.childCoordinators = [profileCoordinator, feedCoordinator]
        let mainController = UITabBarController()
        mainController.viewControllers = [
            profileCoordinator.rootViewController!,
            self.getSound(),
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
    func getFeed() -> UIViewController {
        let vc = FeedViewController()
        return vc
    }

    func getPost() -> PostViewController {
        let vc = PostViewController()
        vc.post = Post(title: "Новый пост")
        return vc

    }

    func getInfo() -> InfoViewController {
        let vc = InfoViewController()
        return vc
    }

    // MARK: - sound

    func getSound() -> SoundViewController{
        let vc = SoundViewController()
        vc.setupPageViewController()
        vc.addSubviews()
        vc.addConstraints()
        vc.view.backgroundColor = .white
        vc.tabBarItem = UITabBarItem(title: "Sound",
                                  image: UIImage(systemName: "music.note.list"),
                                  selectedImage: UIImage(systemName: "music.note.list"))
        return vc
    }

    func getPlayer() -> PlayerViewController{
        let vc = PlayerViewController()
        vc.addSubviews()
        vc.addConstraints()
        return vc
    }

    func getRecorder() -> RecorderViewController{
        let vc = RecorderViewController()
        return vc
    }

    func getTest(_ backgroundColor: UIColor) -> UIViewController{
        let vc = UIViewController()
        vc.view.backgroundColor = backgroundColor
        return vc
    }

}
