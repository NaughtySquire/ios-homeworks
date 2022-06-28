//
//  FeedViewController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 28.04.2022.
//

import UIKit

class FeedViewController: UIViewController {

    private let buttonFactory = ButtonFactory()
    private let userModel: User

    // MARK: - views

    private lazy var textField = CustomTextField(delegate: self)
    private lazy var label = UILabel()

    private lazy var stackButtons: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(buttonFactory.createButton(buttonType: .defaultButton, buttonTitle: "Показать пост", buttonAction: toPostButtonTapHandler))
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(
            buttonFactory.createButton(buttonType: .defaultButton,
                                       buttonTitle: "Проверить пароль"){ [weak self] in
                                           self?.userModel.check(word: (self?.textField.text)!)
                                       }
        )
        stackView.addArrangedSubview(label)
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    // MARK: - init
    init(userModel: User){
        self.userModel = userModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - life cycle

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
        NotificationCenter.default.addObserver(self, selector: #selector(passwordWasCheckedAction(_:)), name: .init(rawValue: "passwordWasChecked"), object: nil)
    }

    // MARK: - functions

    @objc
    func passwordWasCheckedAction(_ notification: NSNotification){
        if notification.userInfo?["isCorrectPassword"] as? Bool ?? false{
            label.text = "Вы ввели правильный пароль"
            label.textColor = .green
        }else{
            label.text = "Вы ввели неправильный пароль"
            label.textColor = .red
        }
    }

    func toPostButtonTapHandler(){
        let post = Post(title: "Новый пост")
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }
}

extension FeedViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
