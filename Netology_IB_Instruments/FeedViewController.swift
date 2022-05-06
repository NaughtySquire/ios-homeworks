//
//  FeedViewController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 28.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    let toPostButton =  UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        toPostButton.setTitle("Показать пост", for: .normal)
        toPostButton.setTitleColor(.blue, for: .normal)
                toPostButton.frame = CGRect(
            x: 20,
            y: 100,
            width: 300,
            height: 100
        )
        toPostButton.addTarget(self, action: #selector(handleToPostButtonTap), for: .touchUpInside)
        self.view.addSubview(toPostButton)

        }
    @objc
    func handleToPostButtonTap(){
        let post = Post(title: "Заголовок поста")
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
}
