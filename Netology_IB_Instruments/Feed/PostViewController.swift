//
//  PostViewController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 28.04.2022.
//

import UIKit

class PostViewController: UIViewController {
    var post: Post?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = post?.title
        let showInfoButton = UIBarButtonItem(
            image: UIImage(systemName: "info"),
            style: .plain,
            target: self,
            action: #selector(showInfo))
        self.navigationItem.rightBarButtonItem = showInfoButton
        navigationController?.isToolbarHidden = false
    }

    @objc
    func showInfo(){
        let infoVC = InfoViewController()
        self.present(infoVC, animated: true)
    }
    
}
