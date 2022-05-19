//
//  PostTableViewCell.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 19.05.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

//    private let post: Post

    // MARK: - views

    private lazy var contentWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        [headerLabel, postImageContainerView, postInfoContainerView].forEach(){view.addSubview($0)}
        return view
    }()
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "some text"
        label.numberOfLines = 2
        return label
    }()

    private lazy var postImageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.addSubview(postImageView)
        return view
    }()
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info")
//        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var postInfoContainerView: UIView = {
        let view = UIView()
        view.addSubview(descriptionLabel)
        view.addSubview(countersContainerView)
        return view
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.text = "a lot of text "
        return label
    }()

    private lazy var countersContainerView: UIView = {
        let view = UIView()
        view.addSubview(likesCounterLabel)
        view.addSubview(viewsCounterLabel)
        return view
    }()

    private lazy var likesCounterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Likes: \(777)"
        return label
    }()

    private lazy var viewsCounterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Views: \(131313)"
        return label
    }()

    // MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        self.post = post
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentWhiteView)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - constraints

    func addConstraints() {
        [contentWhiteView, headerLabel, postImageContainerView, postImageView, postInfoContainerView, descriptionLabel, countersContainerView, likesCounterLabel, viewsCounterLabel].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            contentWhiteView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            contentWhiteView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentWhiteView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            contentWhiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            headerLabel.leftAnchor.constraint(equalTo: contentWhiteView.leftAnchor),
            headerLabel.topAnchor.constraint(equalTo: contentWhiteView.topAnchor),
            headerLabel.rightAnchor.constraint(equalTo: contentWhiteView.rightAnchor),

            postImageContainerView.leftAnchor.constraint(equalTo: contentWhiteView.leftAnchor),
            postImageContainerView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            postImageContainerView.rightAnchor.constraint(equalTo: contentWhiteView.rightAnchor),
            postImageContainerView.widthAnchor.constraint(equalTo: contentWhiteView.widthAnchor),
            postImageContainerView.heightAnchor.constraint(equalTo: postImageContainerView.widthAnchor),

            postImageView.centerYAnchor.constraint(equalTo: postImageContainerView.centerYAnchor),
            postImageView.widthAnchor.constraint(equalTo: postImageContainerView.widthAnchor),

            postInfoContainerView.leftAnchor.constraint(equalTo: contentWhiteView.leftAnchor, constant: 16),
            postInfoContainerView.topAnchor.constraint(equalTo: postImageContainerView.bottomAnchor),
            postInfoContainerView.rightAnchor.constraint(equalTo: contentWhiteView.rightAnchor, constant: -16),
            postInfoContainerView.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor),

            descriptionLabel.leftAnchor.constraint(equalTo: postInfoContainerView.leftAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: postInfoContainerView.topAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: postInfoContainerView.rightAnchor),

            countersContainerView.leftAnchor.constraint(equalTo: postInfoContainerView.leftAnchor),
            countersContainerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            countersContainerView.rightAnchor.constraint(equalTo: postInfoContainerView.rightAnchor),
            countersContainerView.bottomAnchor.constraint(equalTo: postInfoContainerView.bottomAnchor),

            likesCounterLabel.topAnchor.constraint(equalTo: countersContainerView.topAnchor),
            likesCounterLabel.bottomAnchor.constraint(equalTo: countersContainerView.bottomAnchor),
            likesCounterLabel.leftAnchor.constraint(equalTo: countersContainerView.leftAnchor),

            viewsCounterLabel.topAnchor.constraint(equalTo: countersContainerView.topAnchor),
            viewsCounterLabel.bottomAnchor.constraint(equalTo: countersContainerView.bottomAnchor),
            viewsCounterLabel.rightAnchor.constraint(equalTo: countersContainerView.rightAnchor)

        ])
    }
}
