//
//  ProfileViewController.swift
//  Netology_IB_Instruments'
//
//  Created by Роман Олегович on 26.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let myView = Bundle.main.loadNibNamed("ProfileView", owner: nil)?.first as? ProfileView{
            myView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            view.addSubview(myView)
        }

        }

}
