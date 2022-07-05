//
//  UINavigationController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 03.06.2022.
//

import UIKit

extension UINavigationController{
    convenience init(rootViewController: UIViewController, tabBarTitle: String, tabBarSystemImageName: String){
        self.init(rootViewController: rootViewController)
        tabBarItem.title = tabBarTitle
        tabBarItem.image = UIImage(systemName: tabBarSystemImageName)
        navigationBar.backgroundColor = .systemBackground
    }
}
