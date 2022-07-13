//
//  ProfileFactory.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 05.07.2022.
//

import Foundation
import UIKit

protocol ProfileFactory: AnyObject{
    func getProfile(viewModel: ProfileViewModel) -> ProfileViewController
    func getPhotos() -> PhotosViewController
}
