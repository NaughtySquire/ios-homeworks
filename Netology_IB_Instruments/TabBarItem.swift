//
//  TabBarItem.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 28.04.2022.
//

import UIKit

class TabBarItem: UINavigationController {
    init(_ rootViewController: UIViewController,_ title: String,_ systemImageName: String){
        super.init(rootViewController: rootViewController)
        tabBarItem.title = title
        tabBarItem.image = UIImage(systemName: systemImageName)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
