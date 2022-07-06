//
//  ProfileFactory.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 05.07.2022.
//

import Foundation
import UIKit

protocol ProfileFactory{
    func getProfile(coordinator: ProfileCoordinator, userData: UserData) -> ProfileViewController
    func getPhotos(coordinator: ProfileCoordinator) -> PhotosViewController
}
