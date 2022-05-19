//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 28.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    var profileHeader = ProfileHeaderView()
    private let posts = [
        Post(title: "title1"),
        Post(title: "title2"),
        Post(title: "title3"),
        Post(title: "title3")
    ]

    private lazy var mainTable: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        table.tableHeaderView = profileHeader

//        table.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        profileHeader.backgroundColor = .lightGray
        view.addSubview(mainTable)
        addConstraints()
    }


    func addConstraints(){
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeader.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            profileHeader.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            profileHeader.heightAnchor.constraint(equalToConstant: 220)
        ])
        mainTable.translatesAutoresizingMaskIntoConstraints = false
//        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

//            profileHeader.heightAnchor.constraint(equalToConstant: 220)
        ])
        
    }
}
extension ProfileViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
////        tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        220
//    }
}
extension ProfileViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        posts.count
        4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
    }

}
