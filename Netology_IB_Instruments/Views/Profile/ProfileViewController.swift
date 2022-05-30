//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 28.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - cells dictionary
    // key is a number of section that contains values
    private let cells: [Int: [UITableViewCell]] = [
        0 : [
                PhotosTableViewCell()        ],
        1 : [
            PostTableViewCell(style: .default, reuseIdentifier: PostTableViewCell.identifier, post: posts[0]),
            PostTableViewCell(style: .default, reuseIdentifier: PostTableViewCell.identifier, post: posts[1]),
            PostTableViewCell(style: .default, reuseIdentifier: PostTableViewCell.identifier, post: posts[2]),
            PostTableViewCell(style: .default, reuseIdentifier: PostTableViewCell.identifier, post: posts[3])
        ]
    ]

    // MARK: - views

    var profileHeader = ProfileHeaderView()

    private lazy var mainTable: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        table.tableHeaderView = profileHeader
        return table
    }()

//    private lazy var blackView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .black
//        view.alpha = 0
////        view.addSubview(blackViewProfileImage)
//        return view
//    }()

//    private lazy var blackViewProfileImage: UIImageView = {
//        let image = UIImageView(image: UIImage(named: "wolk"))
//        image.layer.masksToBounds = true
//        image.layer.cornerRadius = 64
//        image.layer.borderColor = UIColor.white.cgColor
//        image.backgroundColor = .black
//        image.layer.borderWidth = 3
//        image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        return image
//    }()

    //MARK: - did load
    override func viewDidLoad() {
        super.viewDidLoad()
        profileHeader.frame = CGRect(x: 0, y: 0, width: view.safeAreaLayoutGuide.layoutFrame.width, height: 220)
        view.backgroundColor = .systemGray6
        [mainTable].forEach{
            view.addSubview($0)
        }
        addConstraints()
        setupGesture()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    //MARK: - gestures

    func setupGesture(){
        profileHeader.profileImage.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(avatarTapAction)))
//        blackView.addGestureRecognizer(
//            UITapGestureRecognizer(target: self, action: #selector(blackViewTapAction)))
    }

    func animate(){

    }

    @objc
    func avatarTapAction(){

        UIView.animate(withDuration: 2, animations: {
            self.profileHeader.profileImage.alpha = 0

            self.profileHeader.profileImage.transform = CGAffineTransform(
                translationX: self.view.center.x - self.profileHeader.profileImage.bounds.width / 2,
                y: (self.view.center.y - self.profileHeader.profileImage.bounds.height))
        })
    }

    @objc
    func blackViewTapAction(){
        UIView.animate(withDuration: 2){
                self.profileHeader.profileImage.transform = .identity
        }
    }

    //MARK: - constraints
    func addConstraints(){
        [mainTable].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            mainTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

//            blackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            blackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            blackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            blackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

//            blackViewProfileImage.widthAnchor.constraint(equalToConstant: 128),
//            blackViewProfileImage.heightAnchor.constraint(equalToConstant: 128),
//            blackViewProfileImage.leftAnchor.constraint(equalTo: blackView.leftAnchor),
//            blackViewProfileImage.topAnchor.constraint(equalTo: blackView.topAnchor, constant: 16)

        ])
        
    }
}



//MARK: - extensions
extension ProfileViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        cells.keys.count
    }
}
extension ProfileViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells[section]!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cells[indexPath.section]![indexPath.row]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let photosVC = PhotosViewController()
            photosVC.navigationItem.title = "Photo Gallery"
            navigationController?.pushViewController(photosVC, animated: true)
        }
    }
}
