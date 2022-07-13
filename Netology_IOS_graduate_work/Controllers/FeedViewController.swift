//
//  FeedViewController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 28.04.2022.
//

import UIKit

class FeedViewController: UIViewController {

    private var updateCounter = 15
    private lazy var toPostButton1 =  createToPostButton()
    private lazy var toPostButton2 = createToPostButton()
    private func createToPostButton() -> UIButton{
        let button = UIButton()
        button.setTitle("Показать пост", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(toPostButtonTapHandler), for: .touchUpInside)
        return button
    }
    private lazy var updateTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "До следующего обновления новостей \(self.updateCounter) секунд\(self.getWordEnding(self.updateCounter))"
        label.numberOfLines = 0
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(toPostButton1)
        stackView.addArrangedSubview(toPostButton2)
        stackView.addArrangedSubview(updateTimerLabel)
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){_ in
            self.updateCounter -= 1
            if self.updateCounter <= 0 {
                self.updateCounter = 15
                self.updateFeed()
            }
            self.updateTimerLabel.text = "До следующего обновления новостей \(self.updateCounter) секунд\(self.getWordEnding(self.updateCounter))"

        }
        timer.tolerance = 0.2
        self.view.backgroundColor = .systemBackground
        self.title = "Feed"
        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

    }

    @objc
    func toPostButtonTapHandler(){
        let post = Post(title: "Новый пост")
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }

    func updateFeed() {}

    func getWordEnding(_ num: Int) -> String{
        if !(10...20 ~= num % 100){
        	if num % 10 == 1 {
        	    return "а"
        	}else if 2...4 ~= num % 10{
        	    return "ы"
        	}
        }
        return ""
    }
}
