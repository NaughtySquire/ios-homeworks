//
//  CustomTextField.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 28.06.2022.
//

import UIKit

class CustomTextField: UITextField {

    init(delegate: UITextFieldDelegate) {
        super.init(frame: .zero)
        placeholder = "Введите пароль"
        textColor = .black
        font = UIFont.systemFont(ofSize: 16)
        layer.borderWidth = 0.25
        layer.borderColor = UIColor.lightGray.cgColor
        autocapitalizationType = .none
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
