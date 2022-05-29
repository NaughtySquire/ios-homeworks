//
//  PhotosCollectionViewCell.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 28.05.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    // MARK: - views

    private lazy var contetnWhiteView: UIView = {
        let view = UIView()
        view.addSubview(photo)
        return view
    }()

    private lazy var photo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        return image
    }()

    // MARK: - init

    override init(frame: CGRect = .zero){
        super.init(frame: frame)
        backgroundColor = .green
        contentView.addSubview(contetnWhiteView)
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - functions

    func loadImage(imageName: String){
        photo.image = UIImage(named: imageName)
    }

    // MARK: - constraints
    func addConstraints() {
        [contetnWhiteView, photo].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            contetnWhiteView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            contetnWhiteView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contetnWhiteView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            contetnWhiteView.widthAnchor.constraint(equalTo: contentView.widthAnchor),

            photo.leftAnchor.constraint(equalTo: contetnWhiteView.leftAnchor),
            photo.topAnchor.constraint(equalTo: contetnWhiteView.topAnchor),
            photo.heightAnchor.constraint(equalTo: contetnWhiteView.heightAnchor),
            photo.widthAnchor.constraint(equalTo: contetnWhiteView.widthAnchor)
        ])
    }

}
