//
//  UINavigationController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 03.06.2022.
//

import UIKit

extension UINavigationController{
    convenience init(rootViewController: UIViewController, tabBarTitle: String, tabBarystemImageName: String){
        self.init(rootViewController: rootViewController)
        tabBarItem.title = tabBarTitle
        tabBarItem.image = UIImage(systemName: tabBarystemImageName)
        navigationBar.backgroundColor = .systemBackground
    }
}
