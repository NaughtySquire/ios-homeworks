//
//  ProfileHeaderView.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 29.04.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    private var statusText = "Сделал дело - дело сделано."
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "wolk")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 68
        image.layer.borderColor = UIColor.white.cgColor
        image.backgroundColor = .black
        image.layer.borderWidth = 3
        return image
    }()

    private lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "Мудрый волк"
        return label
    }()
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.text = statusText
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
        textField.addTarget(self, action: #selector(statusTextFieldChangesHandler), for: .editingChanged)
        return textField
    }()
    private lazy var setStatusButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
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

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        addSubview(statusTextField)
        addSubview(statusLabel)
        addSubview(fullnameLabel)
        addSubview(profileImage)
        addSubview(setStatusButton)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func updateStatus(){
        statusLabel.text = statusText
        print(statusLabel.text ?? "Статус не установлен")

    }

    @objc
    func statusTextFieldChangesHandler(_ textField: UITextField){
        statusText = textField.text ?? statusText
    }

    func addConstraints(){
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        fullnameLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            setStatusButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            setStatusButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            setStatusButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),

            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            profileImage.bottomAnchor.constraint(lessThanOrEqualTo: setStatusButton.topAnchor, constant: -16),
            profileImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor),

            fullnameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            fullnameLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            fullnameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 16),

            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -16),
            statusLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            statusLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 16),

            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -16),
            statusTextField.rightAnchor.constraint(equalTo: self.rightAnchor),
            statusTextField.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 16)
            
        ])
    }

}
