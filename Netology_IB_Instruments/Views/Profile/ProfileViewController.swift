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
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        profileHeader.frame = CGRect(x: 0, y: 0, width: view.safeAreaLayoutGuide.layoutFrame.width, height: 220)
        view.addSubview(mainTable)
        addConstraints()
    }


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
extension ProfileViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
extension ProfileViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
    }

}
