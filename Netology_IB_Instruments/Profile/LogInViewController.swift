//
//  LogInViewController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 12.05.2022.
//

import UIKit

class LogInViewController: UIViewController {
    private lazy var contentView: UIView = {
        let view = UIView()
        view.addSubview(logoImageView)
        view.addSubview(textFieldsContainerView)
        view.addSubview(logInButton)
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(contentView)
        return scrollView
    }()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var textFieldsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemCyan
        view.addSubview(logInITextField)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()

    private lazy var logInITextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()

    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("LogIn", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(named: "logInButtonColor")
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        view.addSubview(scrollView)
        view.bringSubviewToFront(scrollView)
        addConstraints()
    }


    func addConstraints(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        textFieldsContainerView.translatesAutoresizingMaskIntoConstraints = false
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInITextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),

            textFieldsContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            textFieldsContainerView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            textFieldsContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            textFieldsContainerView.heightAnchor.constraint(equalToConstant: 100),

            logInITextField.leftAnchor.constraint(equalTo: textFieldsContainerView.leftAnchor),
            logInITextField.topAnchor.constraint(equalTo: textFieldsContainerView.topAnchor),
            logInITextField.widthAnchor.constraint(equalTo: textFieldsContainerView.widthAnchor),
            logInITextField.heightAnchor.constraint(equalTo: textFieldsContainerView.heightAnchor, multiplier: 0.5),

            logInButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            logInButton.topAnchor.constraint(equalTo: textFieldsContainerView.bottomAnchor, constant: 16),
            logInButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50)

        ])
    }

}
