//
//  FeedViewController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 28.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    private lazy var toPostButton1 =  createToPostButton()
    private lazy var toPostButton2 = createToPostButton()
    private func createToPostButton() -> UIButton{
        let button = UIButton()
        button.setTitle("Показать пост", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(toPostButtonTapHandler), for: .touchUpInside)
        return button
    }
    private lazy var stackButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(toPostButton1)
        stackView.addArrangedSubview(toPostButton2)
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "Feed"
        self.view.addSubview(stackButtons)
        stackButtons.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackButtons.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc
    func toPostButtonTapHandler(){
        let post = Post(title: "Новый пост")
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
}
