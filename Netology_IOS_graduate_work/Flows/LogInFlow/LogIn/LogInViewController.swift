//
//  LogInViewController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 12.05.2022.
//

import UIKit

class LogInViewController: UIViewController {

    // MARK: - properties
    private var viewModel: LogInViewModel

    // MARK: - views

    private lazy var contentView: UIView = {
        let view = UIView()
        [logoImageView,
         textFieldsContainerView,
         logInButton,
         logInIndicator,
         logInStateLabel].forEach{
            view.addSubview($0)

        }
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
        [usernameTextField, passwordTextField].forEach(){view.addSubview($0)}
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()

    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderWidth = 0.25
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Email or phone"
        textField.text = "wolk"
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
        textField.text = "Пароль"
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()

    let logInIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }()
    let logInStateLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы ввели неправильный логин или пароль"
        label.textColor = .red
        label.alpha = 0
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var logInButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("LogIn", for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
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

    // MARK: - init
    
    init(viewModel: LogInViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - life cycle

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

    // MARK: functions
    @objc
    func logInButtonTapped(){
        viewModel.handleAction(.logInButtonTapped(username: usernameTextField.text!,
                                                  password: passwordTextField.text!))
    }

    func addSubviews(){
        self.view.addSubview(scrollView)
    }


    func setupViewModel(){
        viewModel.stateChanged = {[weak self]  state in
            switch state{
            case .initial:
                ()
            case .loading:
                self?.logInStateLabel.alpha = 0
                self?.logInIndicator.startAnimating()
            case .logInError:
                self?.logInIndicator.stopAnimating()
                self?.logInStateLabel.alpha = 1
            }
        }
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

        [scrollView,
         contentView,
         logoImageView,
         textFieldsContainerView,
         usernameTextField,
         passwordTextField,
         logInButton,
         logInIndicator,
         logInStateLabel].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

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

            usernameTextField.leftAnchor.constraint(equalTo: textFieldsContainerView.leftAnchor),
            usernameTextField.topAnchor.constraint(equalTo: textFieldsContainerView.topAnchor),
            usernameTextField.widthAnchor.constraint(equalTo: textFieldsContainerView.widthAnchor),
            usernameTextField.heightAnchor.constraint(equalTo: textFieldsContainerView.heightAnchor, multiplier: 0.5),

            passwordTextField.leftAnchor.constraint(equalTo: textFieldsContainerView.leftAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: textFieldsContainerView.bottomAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: textFieldsContainerView.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: textFieldsContainerView.heightAnchor, multiplier: 0.5),

            logInButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            logInButton.topAnchor.constraint(equalTo: textFieldsContainerView.bottomAnchor, constant: 16),
            logInButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),

            logInIndicator.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 10),
            logInIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            logInStateLabel.topAnchor.constraint(equalTo: logInButton.bottomAnchor),
            logInStateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            logInStateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
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
