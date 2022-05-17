//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 28.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    var profileHeader = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .lightGray
        view.addSubview(profileHeader)
        addConstraints()
    }

    func addConstraints(){
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeader.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            profileHeader.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            profileHeader.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
}
