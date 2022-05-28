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
    //MARK: - did load
    override func viewDidLoad() {
        super.viewDidLoad()
        profileHeader.frame = CGRect(x: 0, y: 0, width: view.safeAreaLayoutGuide.layoutFrame.width, height: 220)
        view.backgroundColor = .systemGray6
        view.addSubview(mainTable)
        addConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    //MARK: - constraints
    func addConstraints(){
        mainTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
