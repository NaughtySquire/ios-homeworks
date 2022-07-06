//
//  ProfileHeaderView.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 29.04.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    private let userData: UserData
    private lazy var contentWhiteView = UIView()

    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: userData.avatarImageName)
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 64
        image.layer.borderColor = UIColor.white.cgColor
        image.backgroundColor = .black
        image.layer.borderWidth = 3
        image.isUserInteractionEnabled = true
        return image
    }()

    private lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = userData.name + " " + userData.surname
        return label
    }()
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.text = userData.status
        label.isUserInteractionEnabled = true
        return label
    }()
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.delegate = self
        textField.addTarget(self, action: #selector(statusTextFieldChangesHandler), for: .editingChanged)
        return textField
    }()
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitleColor( UIColor.white , for: .normal)
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.backgroundColor = .systemBlue
        button.setTitle("Set status", for: .normal)
        button.addTarget(self, action: #selector(updateStatus), for: .touchUpInside)
        return button
    }()

    init(userData: UserData) {
        self.userData = userData
        super.init(frame: .zero)
        [statusTextField, statusLabel, fullnameLabel, profileImage, setStatusButton, profileImage].forEach{
            contentWhiteView.addSubview($0)
        }
        self.addSubview(contentWhiteView)
        backgroundColor = .systemGray6
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func updateStatus(){
        statusLabel.text = userData.status
        print(statusLabel.text ?? "Статус не установлен")

    }

    @objc
    func statusTextFieldChangesHandler(_ textField: UITextField){
        userData.status = textField.text ?? userData.status
    }

    func addConstraints(){
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        fullnameLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        contentWhiteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            contentWhiteView.leftAnchor.constraint(equalTo: self.leftAnchor),
            contentWhiteView.topAnchor.constraint(equalTo: self.topAnchor),
            contentWhiteView.rightAnchor.constraint(equalTo: self.rightAnchor),
            contentWhiteView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            setStatusButton.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor, constant: -10),
            setStatusButton.rightAnchor.constraint(equalTo: contentWhiteView.rightAnchor),
            setStatusButton.leftAnchor.constraint(equalTo: contentWhiteView.leftAnchor),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),

            profileImage.topAnchor.constraint(equalTo: contentWhiteView.topAnchor, constant: 16),
            profileImage.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -16),
            profileImage.leftAnchor.constraint(equalTo: contentWhiteView.leftAnchor),
            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor),

            fullnameLabel.topAnchor.constraint(equalTo: contentWhiteView.topAnchor, constant: 27),
            fullnameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 16),
            fullnameLabel.rightAnchor.constraint(equalTo: contentWhiteView.rightAnchor, constant: -16),

            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -16),
            statusLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 16),
            statusLabel.rightAnchor.constraint(equalTo: contentWhiteView.rightAnchor, constant: -16),

            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -16),
            statusTextField.rightAnchor.constraint(equalTo: contentWhiteView.rightAnchor),
            statusTextField.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 16),
        ])
    }

}

extension ProfileHeaderView: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
    }
}
