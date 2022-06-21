//
//  InfoViewController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 28.04.2022.
//

import UIKit

class InfoViewController: UIViewController {
    let showAlertButton = UIButton(frame: CGRect(
        x: 20,
        y: 100,
        width: 300,
        height: 100
    ))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        showAlertButton.setTitle("Показать предупреждение", for: .normal)
        showAlertButton.setTitleColor(.blue, for: .normal)
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        self.view.addSubview(showAlertButton)
    }
    @objc
    func showAlert(){
            let alert = UIAlertController(title: "Это заголовок", message: "Это сообщение", preferredStyle: .alert)
            let firstAction = UIAlertAction(title: "Сделать так",
                                            style: .default,
                                            handler: { _ in
                print("Зачем сын просил у отца парты?")
            })
        alert.addAction(firstAction)
        let secondAction = UIAlertAction(title: "Сделать не так",
                                        style: .cancel,
                                        handler: { _ in
            print("Они были нужны ему, чтобы")
        })
    alert.addAction(secondAction)
        present(alert, animated: true)
    }


}
