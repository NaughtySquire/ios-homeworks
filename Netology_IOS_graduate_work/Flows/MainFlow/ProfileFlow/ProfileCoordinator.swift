//
//  ProfileCoordinator.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 02.07.2022.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator{
    private var profileFactory: ProfileFactory
    private(set) var rootViewController: UINavigationController?
    private let userData: UserData
    init(profileFactory: ProfileFactory, userData: UserData){
        self.profileFactory = profileFactory
        self.userData = userData
    }

    func start() {
        goToProfileVC()
    }

    private func goToProfileVC(){
        let vc = profileFactory.getProfile(coordinator: self, userData: userData)
        vc.photosCellDidTap = { [weak self] in
            self?.goToPhotosVC()
        }
        rootViewController = UINavigationController(rootViewController: vc, tabBarTitle: "Profile", tabBarSystemImageName: "person.crop.circle")
    }
    private func goToPhotosVC(){
        let vc = profileFactory.getPhotos(coordinator: self)
        rootViewController?.pushViewController(vc, animated: true)
    }
}
