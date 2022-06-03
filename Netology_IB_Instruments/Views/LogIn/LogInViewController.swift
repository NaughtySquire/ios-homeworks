//
//  LogInViewController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 12.05.2022.
//

import UIKit

class LogInViewController: UIViewController {
    // MARK: - views
    private lazy var contentView: UIView = {
        let view = UIView()
        [logoImageView, textFieldsContainerView, logInButton].forEach(){view.addSubview($0)}
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
        view.backgroundColor = .systemGray6
        [logInTextField, passwordTextField].forEach(){view.addSubview($0)}
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()

    private lazy var logInTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderWidth = 0.25
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Email or phone"
        textField.autocapitalizationType = .none
        textField.delegate = self
        return textField
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderWidth = 0.25
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Password"
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()

    private lazy var logInButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("LogIn", for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        button.configurationUpdateHandler = { clousureButton in
            switch clousureButton.state{
            case .normal:
                clousureButton.configuration?.baseBackgroundColor = UIColor(patternImage: UIImage(named: "blue_pixel")!).withAlphaComponent(1)
            default:
                clousureButton.configuration?.baseBackgroundColor = UIColor(patternImage: UIImage(named: "blue_pixel")!).withAlphaComponent(0.8)

            }
        }
        return button
    }()

    // MARK: - did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        view.addSubview(scrollView)
        addConstraints()
    }
    // MARK: functions
    @objc
    func goToProfile(){
        let feedVC = UINavigationController(rootViewController: FeedViewController(), tabBarTitle: "Feed", tabBarystemImageName: "newspaper.circle.fill")
        let profileVC = UINavigationController(rootViewController: ProfileViewController(), tabBarTitle: "Profile", tabBarystemImageName: "person.crop.circle.fill")
        let rootVC = UITabBarController()
        rootVC.viewControllers = [profileVC, feedVC]
        rootVC.tabBar.backgroundColor = .systemBackground
        navigationController?.pushViewController(rootVC, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc
    func kbdShow(notification: NSNotification){
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            scrollView.contentInset.bottom = kbdSize.height + 50
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height + 100, right: 0)
        }
    }
    @objc
    func kbdHide(){
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

    // MARK: constraints
    func addConstraints(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        textFieldsContainerView.translatesAutoresizingMaskIntoConstraints = false
        logInTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        logInButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),


            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),

            textFieldsContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            textFieldsContainerView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            textFieldsContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            textFieldsContainerView.heightAnchor.constraint(equalToConstant: 100),

            logInTextField.leftAnchor.constraint(equalTo: textFieldsContainerView.leftAnchor),
            logInTextField.topAnchor.constraint(equalTo: textFieldsContainerView.topAnchor),
            logInTextField.widthAnchor.constraint(equalTo: textFieldsContainerView.widthAnchor),
            logInTextField.heightAnchor.constraint(equalTo: textFieldsContainerView.heightAnchor, multiplier: 0.5),

            passwordTextField.leftAnchor.constraint(equalTo: textFieldsContainerView.leftAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: textFieldsContainerView.bottomAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: textFieldsContainerView.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: textFieldsContainerView.heightAnchor, multiplier: 0.5),

            logInButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            logInButton.topAnchor.constraint(equalTo: textFieldsContainerView.bottomAnchor, constant: 16),
            logInButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }

}
// MARK: - extensions
extension LogInViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
