//
//  LoginFactory.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 05.07.2022.
//

import Foundation
import UIKit

protocol LogInFactory: AnyObject{
    func getLogIn(viewModel: LogInViewModel) -> LogInViewController
}
