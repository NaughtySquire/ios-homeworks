//
//  PhotosTableViewCell.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 25.05.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    // MARK: - views
    private lazy var contentWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        [titileContainerView, photosStackView].forEach(){
            view.addSubview($0)
        }
        return view
    }()

    private lazy var titileContainerView: UIView = {
        let view = UIView()
        [titleLabel, titleArrowButton].forEach(){
            view.addSubview($0)
        }
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

    private lazy var titleArrowButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrow.right"), for: .normal)
        return button
    }()

    private lazy var photosStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()

    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - constraints
    func addConstraints(){
        [contentWhiteView].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            contentWhiteView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            contentWhiteView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            contentWhiteView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            contentWhiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            titileContainerView.leftAnchor.constraint(equalTo: contentWhiteView.leftAnchor),
            titileContainerView.topAnchor.constraint(equalTo: contentWhiteView.topAnchor),
            titileContainerView.rightAnchor.constraint(equalTo: contentWhiteView.rightAnchor),
            titileContainerView.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor),

            titleLabel.leftAnchor.constraint(equalTo: titileContainerView.leftAnchor),
            titleLabel.heightAnchor.constraint(equalTo: titileContainerView.heightAnchor),

            titleArrowButton.rightAnchor.constraint(equalTo: titileContainerView.rightAnchor),
            titleArrowButton.heightAnchor.constraint(equalTo: titileContainerView.heightAnchor),
            titleArrowButton.widthAnchor.constraint(equalTo: titleArrowButton.heightAnchor),

            photosStackView.leftAnchor.constraint(equalTo: contentWhiteView.leftAnchor),
            photosStackView.topAnchor.constraint(equalTo: titileContainerView.bottomAnchor, constant: 12),

        ])
    }
}
