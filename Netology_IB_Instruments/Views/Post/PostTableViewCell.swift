//
//  PostTableViewCell.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 19.05.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    var post: Post = Post(title: "Мемы с волками",
                                  author: "“Постироничные мемы с волками”",
                                  description: "Мемы с волками и цитатами иронизируют над классическими “глубокомысленными” картинками. Обычно цитату переделывают до абсурда или вообще заменяют другой мемной фразой, не относящейся к животным.",
                                  imageName: "Цитата волка",
                                  likes: 217,
                                  views: 314)

    // MARK: - views

    private lazy var contentWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        [headerLabel, postImageView, postInfoContainerView].forEach(){view.addSubview($0)}
        return view
    }()
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = post.title
        label.numberOfLines = 2
        return label
    }()


    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.image = UIImage(named: post.imageName)
        imageView.contentMode = .scaleAspectFit
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
        label.text = post.description
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
        label.text = "Likes: \(post.likes)"
        return label
    }()

    private lazy var viewsCounterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Views: \(post.views)"
        return label
    }()

    // MARK: - init

    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, post: Post) {
        self.post = post
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentWhiteView)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - constraints

    func addConstraints() {
        [contentWhiteView, headerLabel, postImageView, postInfoContainerView, descriptionLabel, countersContainerView, likesCounterLabel, viewsCounterLabel].forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            contentWhiteView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            contentWhiteView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentWhiteView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            contentWhiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            headerLabel.leftAnchor.constraint(equalTo: contentWhiteView.leftAnchor, constant: 16),
            headerLabel.topAnchor.constraint(equalTo: contentWhiteView.topAnchor),
            headerLabel.rightAnchor.constraint(equalTo: contentWhiteView.rightAnchor),

            postImageView.leftAnchor.constraint(equalTo: contentWhiteView.leftAnchor),
            postImageView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            postImageView.rightAnchor.constraint(equalTo: contentWhiteView.rightAnchor),
            postImageView.widthAnchor.constraint(equalTo: contentWhiteView.widthAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),

            postInfoContainerView.leftAnchor.constraint(equalTo: contentWhiteView.leftAnchor, constant: 16),
            postInfoContainerView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            postInfoContainerView.rightAnchor.constraint(equalTo: contentWhiteView.rightAnchor, constant: -16),
            postInfoContainerView.bottomAnchor.constraint(equalTo: contentWhiteView.bottomAnchor),

            descriptionLabel.leftAnchor.constraint(equalTo: postInfoContainerView.leftAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: postInfoContainerView.topAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: postInfoContainerView.rightAnchor),

            countersContainerView.leftAnchor.constraint(equalTo: postInfoContainerView.leftAnchor),
            countersContainerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
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
