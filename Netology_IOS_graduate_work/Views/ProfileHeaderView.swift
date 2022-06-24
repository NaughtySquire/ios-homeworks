//
//  ProfileHeaderView.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 29.04.2022.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    private var statusText = "Сделал дело - дело сделано."
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "wolk")
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
        label.text = "Мудрый волк"
        return label
    }()
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.text = statusText
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

    init() {
        super.init(frame: .zero)
        addSubview(statusTextField)
        addSubview(statusLabel)
        addSubview(fullnameLabel)
        addSubview(profileImage)
        addSubview(setStatusButton)
        backgroundColor = .systemGray6
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
        setStatusButton.snp.makeConstraints(){make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }

        profileImage.snp.makeConstraints(){make in
            make.left.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
            make.bottom.equalTo(setStatusButton.snp_topMargin).inset(-16)
            make.width.equalTo(profileImage.snp.height)
        }

        fullnameLabel.snp.makeConstraints(){make in
            make.left.equalTo(profileImage.snp_rightMargin).inset(-16)
            make.top.equalToSuperview().inset(27)
            make.right.equalToSuperview()
        }

        statusTextField.snp.makeConstraints(){make in
            make.left.equalTo(profileImage.snp_rightMargin).inset(-16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalTo(setStatusButton.snp_topMargin).inset(-16)
            make.height.equalTo(40)
        }


        statusLabel.snp.makeConstraints(){make in
            make.left.equalTo(profileImage.snp_rightMargin).inset(-16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalTo(statusTextField.snp_topMargin).inset(-16)
        }

    }

}
