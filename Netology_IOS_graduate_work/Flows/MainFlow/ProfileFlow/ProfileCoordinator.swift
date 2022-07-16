//
//  ProfileCoordinator.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 02.07.2022.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator{

    var controllerFactory: ModuleFactory

    private(set) var rootViewController: UINavigationController?
    private let userData: UserData

    init(_ controllerFactory: ModuleFactory, _ userData: UserData){
        self.controllerFactory = controllerFactory
        self.userData = userData
    }

    func start() {
        goToProfileVC()
    }

    private func goToProfileVC(){
        let viewModel = ProfileViewModel(userData: userData)
        viewModel.goToPhotos = {[weak self] in
            self?.goToPhotosVC()
        }
        let vc = controllerFactory.getProfile(viewModel: viewModel)
        rootViewController = UINavigationController(rootViewController: vc,
                                                    tabBarTitle: "Profile",
                                                    tabBarSystemImageName: "person.crop.circle")
    }
    private func goToPhotosVC(){
        let vc = controllerFactory.getPhotos()
        rootViewController?.pushViewController(vc, animated: true)
    }
}
