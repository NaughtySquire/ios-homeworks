//
//  CustomButton.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 28.06.2022.
//

import UIKit

class CustomButton: UIButton {

    // MARK: - init
    init(buttonAction: @escaping () -> ()){
        super.init(frame: .zero)
        self.addAction(.init{_ in buttonAction()}, for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
