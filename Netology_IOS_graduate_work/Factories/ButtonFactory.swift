//
//  BittonFactory.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 28.06.2022.
//

import UIKit

enum ButtonType{
    case defaultButton
    case logInButton
}

class ButtonFactory{
    func createButton(buttonType: ButtonType, buttonTitle: String, buttonAction: @escaping () -> ()) -> CustomButton{
        let button = CustomButton(buttonAction: buttonAction)
        button.layer.masksToBounds = false
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.white , for: .normal)
        switch buttonType {
        case .defaultButton:
            button.layer.cornerRadius = 10
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 4, height: 4)
            button.layer.shadowRadius = 4
            button.layer.shadowOpacity = 0.7
            button.backgroundColor = .systemBlue
        case .logInButton:
            button.layer.cornerRadius = 10
            button.backgroundColor = UIColor(patternImage: UIImage(named: "blue_pixel")!)
        }
        return button
    }
}
