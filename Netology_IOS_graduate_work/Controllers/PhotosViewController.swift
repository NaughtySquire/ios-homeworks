//
//  PhotosViewController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 28.05.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {


    private let imageFacade = ImagePublisherFacade()

    // MARK: - data

    private var currentNumberOfPhotos = 0
    private let photos: [UIImage] = {
        var images: [UIImage] = []
        for i in 0..<20{
            images.append(UIImage(named: "Photos/\(i)")!)
        }
        return images
    }()

    // MARK: - views

    private lazy var photosCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collection
    }()

    // MARK: - did load
    override func viewDidLoad() {
        super.viewDidLoad()
        imageFacade.subscribe(self)
        imageFacade.addImagesWithTimer(time: 0.5, repeat: 20, userImages: photos)
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        view.addSubview(photosCollection)
        addConstraints()

    }

    override func viewWillDisappear(_ animated: Bool) {
        imageFacade.rechargeImageLibrary()
        imageFacade.removeSubscription(for: self)
    }

    //MARK: - constraints

    func addConstraints(){
        photosCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photosCollection.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            photosCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photosCollection.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            photosCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}


// MARK: - extensions

extension PhotosViewController: UICollectionViewDelegate{

}

extension PhotosViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentNumberOfPhotos
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.loadImage(imageName: "Photos/\(indexPath.row)")
        return cell
    }


}
extension PhotosViewController: UICollectionViewDelegateFlowLayout{
    private var sideInset: CGFloat {8}
    private var numberOfItemsInARow: CGFloat {3}
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width - sideInset * (numberOfItemsInARow + 1)) / numberOfItemsInARow
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
}

extension PhotosViewController: ImageLibrarySubscriber{
    func receive(images: [UIImage]) {
        currentNumberOfPhotos += 1
        photosCollection.reloadData()
    }
}
