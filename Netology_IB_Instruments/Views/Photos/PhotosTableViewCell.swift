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
        [titileContainerView, photosStackView].forEach{
            view.addSubview($0)
        }
        return view
    }()

    private lazy var titileContainerView: UIView = {
        let view = UIView()
        [titleLabel, titleArrowImage].forEach{
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

    private lazy var titleArrowImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "arrow.right"))
        return image
    }()

    private lazy var photosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        for i in 0..<4{
            let image = UIImageView(image: UIImage(named: "Photos/\(i)"))
            image.layer.cornerRadius = 10
            image.layer.masksToBounds = true
            stackView.addArrangedSubview(image)
        }
        return stackView
    }()

    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentWhiteView)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - constraints
    func addConstraints(){
        [contentWhiteView, titileContainerView, titleLabel, titleArrowImage, photosStackView].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            contentWhiteView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            contentWhiteView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            contentWhiteView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            contentWhiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//
            titileContainerView.leftAnchor.constraint(equalTo: contentWhiteView.leftAnchor),
            titileContainerView.topAnchor.constraint(equalTo: contentWhiteView.topAnchor),
            titileContainerView.rightAnchor.constraint(equalTo: contentWhiteView.rightAnchor),

            titleLabel.leftAnchor.constraint(equalTo: titileContainerView.leftAnchor),
            titleLabel.heightAnchor.constraint(equalTo: titileContainerView.heightAnchor),

            titleArrowImage.rightAnchor.constraint(equalTo: titileContainerView.rightAnchor),
            titleArrowImage.heightAnchor.constraint(equalTo: titileContainerView.heightAnchor),
            titleArrowImage.widthAnchor.constraint(equalTo: titleArrowImage.heightAnchor),

            photosStackView.leftAnchor.constraint(equalTo: contentWhiteView.leftAnchor),
            photosStackView.topAnchor.constraint(equalTo: titileContainerView.bottomAnchor, constant: 12),
            photosStackView.rightAnchor.constraint(equalTo: contentWhiteView.rightAnchor),
            photosStackView.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor, constant: -12)

        ])
        photosStackView.arrangedSubviews.forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    $0.widthAnchor.constraint(equalTo: photosStackView.widthAnchor, multiplier: 0.25, constant: -6),
                    $0.heightAnchor.constraint(equalTo: $0.widthAnchor),
                    $0.topAnchor.constraint(equalTo: photosStackView.topAnchor),
                    $0.bottomAnchor.constraint(equalTo: photosStackView.bottomAnchor)
                ])
        }
    }
}
