//
//  PhotosViewController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 28.05.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    // MARK: - properties
    private let numberOfPhotos = 20
    private let photos: [UIImage] = {
        var images = [UIImage]()
        for i in 0..<500{
            images.append(UIImage(named: "Photos/\(i % 20)")!)
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
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        view.addSubview(photosCollection)
        addConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        // Так сильно у меня мак еще не нагревался
        let imageProcessor = ImageProcessor()
        let startTime = CFAbsoluteTimeGetCurrent()
        /*
         Тайминги при общем параллельном запуске
         тест 1:
            userInteractive:  20.276864051818848
            userInitiated:  20.392497062683105
            default:  20.491680026054382
            utility:  21.11422610282898
            background:  24.736585021018982
         тест 2:
            userInteractive:  19.857185006141663
            userInitiated:  19.99058997631073
            default:  20.152832984924316
            background:  23.12870502471924
            utility:  23.133488059043884
         */
        //  Затем все методы запускал поотдельности.
        //  Один раскоментировал, запустил, записал время, закоментировал, перешел к следующему.
//        imageProcessor.processImagesOnThread(sourceImages: photos,
//                                             filter: .allCases.randomElement()!,
//                                             qos: .utility,
//                                             completion: {images in
//            print("utility: ", CFAbsoluteTimeGetCurrent() - startTime)
//        }) // 500 фото -> (18.3, 15.7) сек


//        imageProcessor.processImagesOnThread(sourceImages: photos,
//                                             filter: .allCases.randomElement()!,
//                                             qos: .default,
//                                             completion: {images in
//            print("default: ", CFAbsoluteTimeGetCurrent() - startTime)
//        }) // 500 фото -> (14.8, 14.4) сек


//        imageProcessor.processImagesOnThread(sourceImages: photos,
//                                             filter: .allCases.randomElement()!,
//                                             qos: .background,
//                                             completion: {images in
//            print("background: ", CFAbsoluteTimeGetCurrent() - startTime)
//        })  // 500 фото -> 67 сек, 200 фото -> 27.1 сек -
//        									Очень странные тайминги. 200 фото тестил пару раз.
//        									Может, дело в рандомном фильтре, но все-таки именно этот метод
//        									несколько раз работал сильно дольше других


//        imageProcessor.processImagesOnThread(sourceImages: photos,
//                                             filter: .allCases.randomElement()!,
//                                             qos: .userInitiated,
//                                             completion: {images in
//            print("userInitiated: ",CFAbsoluteTimeGetCurrent() - startTime)
//    })      // 500 фото -> (19.0, 15.6) сек


//        imageProcessor.processImagesOnThread(sourceImages: photos,
//                                             filter: .allCases.randomElement()!,
//                                             qos: .userInteractive,
//                                             completion: {images in
//            print("userInteractive: ",CFAbsoluteTimeGetCurrent() - startTime)
//    })      // 500 фото -> (15.7, 15.6) сек

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
        numberOfPhotos
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
