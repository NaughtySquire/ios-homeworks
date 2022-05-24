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
        Post(title: "Мемы с волками",
             author: "“Постироничные мемы с волками”",
             description: "Мемы с волками и цитатами иронизируют над классическими “глубокомысленными” картинками. Обычно цитату переделывают до абсурда или вообще заменяют другой мемной фразой, не относящейся к животным.",
             imageName: "Цитата волка",
             likes: 217,
             views: 314),
        Post(title: "Волки смеются",
             author: "woxys",
             description: "Мем с белыми волками показывает разные ситуации, когда двое смеются, а один – нет. Это может быть из-за того, что ему не понравилась шутка. Или из-за того, что он сам стал объектом насмешек. Или из-за того, что шутка неуместна в данный момент. \nЧаще всего речь идет про какие-то моменты в общении с семьей, друзьями или коллегами. Также смеющихся волков часто фотожабят, их может быть гораздо больше, чем на изначальном шаблоне.",
             imageName: "Волки смеются",
             likes: 777,
             views: 777),
        Post(title: "Волк с пальцем у виска",
             author: "Мультик “Маша и Медведь“",
             description: "Мемы с волком встречаются в комментариях ВКонтакте. Их постят как реакцию на что-то глупое. Жест с пальцем у виска демонстрирует то, что у человека не все в порядке с головой.\nВ классических мемах картинка с волком завершает какую-либо фразу или диалог. Часто от лица волка говорят персонажи, животные или предметы, которые недоумевают от происходящего.",
             imageName: "Волк крутит у виска",
             likes: -273,
             views: 98),
        Post(title: "Гордый волк",
             author: "W.O.L.F. Sanctuary ",
             description: "Мем с гордым волком чаще всего сопровождают фразами, которые так или иначе относятся к этим животным. Например, перефразированными известные пословицы “Работа не волк, в лес не убежит” или “Сколько волка не корми, он все равно в лес смотрит”. Также используются отсылки к сказкам и кино.\nРеже картинка с волком на все случаи жизни используется для иллюстрации уверенности в себе, гордости. Такое значение ей, в основном, придается на Западе.",
             imageName: "Гордый волк",
             likes: 666,
             views: 13)
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
        PostTableViewCell(style: .default, reuseIdentifier: PostTableViewCell.identifier, post: posts[indexPath.row])
    }

}
