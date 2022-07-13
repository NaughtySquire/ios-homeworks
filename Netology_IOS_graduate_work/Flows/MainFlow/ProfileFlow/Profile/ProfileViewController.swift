//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 28.04.2022.
//

import UIKit

protocol ProfileViewControllerDelagate{
    func updateStatus(status: String)
}

class ProfileViewController: UIViewController {

    // MARK: - properties
    private var viewModel: ProfileViewModel
    private var delegate: ProfileViewControllerDelagate?

    // MARK: - cells dictionary
    // key is a number of section that contains values
    private let cells: [Int: [UITableViewCell]] = [
        0 : [
                PhotosTableViewCell()
        ],
        1 : [
            PostTableViewCell(style: .default, reuseIdentifier: PostTableViewCell.identifier, post: posts[0]),
            PostTableViewCell(style: .default, reuseIdentifier: PostTableViewCell.identifier, post: posts[1]),
            PostTableViewCell(style: .default, reuseIdentifier: PostTableViewCell.identifier, post: posts[2]),
            PostTableViewCell(style: .default, reuseIdentifier: PostTableViewCell.identifier, post: posts[3])
        ]
    ]

    // MARK: - views

    private lazy var profileHeader = ProfileHeaderView(viewModel: viewModel,
                                                       frame: CGRect(x: 0,
                                                                     y: 0,
                                                                     width: view.safeAreaLayoutGuide.layoutFrame.width,
                                                                     height: 220))

    private lazy var mainTable: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        table.tableHeaderView = profileHeader
        return table
    }()

    private lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.7)
        view.alpha = 0
        [blackViewProfileImage, blackViewCross].forEach{
            view.addSubview($0)
        }
        return view
    }()

    private lazy var blackViewProfileImage: UIImageView = {
        let image = UIImageView(image: profileHeader.profileImage.image)
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 64
        image.layer.borderColor = UIColor.white.cgColor
        image.backgroundColor = .black
        image.layer.borderWidth = 3
        image.isUserInteractionEnabled = true
        return image
    }()

    private lazy var blackViewCross: UILabel = {
        let label = UILabel()
        label.text = "X"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.isUserInteractionEnabled = true
        label.alpha = 0
        return label
    }()

    // MARK: - init

    init(viewModel: ProfileViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.delegate = self.profileHeader
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - life cycle

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: - functions

    func addSubviews(){
        [mainTable, blackView].forEach{
            view.addSubview($0)
        }
    }

    func setupViewModel(){
        viewModel.stateChanged = { [weak self] state in
            switch state{
            case .initial:
                ()
            case .statusDidChange(let newStatus):
                self?.delegate?.updateStatus(status: newStatus)
            }
        }
    }

    // MARK: - gestures

    func setupGesture(){
        profileHeader.profileImage.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(avatarTapAction)))
        blackViewCross.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(blackViewCrossTapAction)))
        blackView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(changeAvatarCornerRadius(_ : ))))
    }

    @objc
    private func avatarTapAction(){
        let scalilgFactor = self.mainTable.bounds.width / self.blackViewProfileImage.bounds.width
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 1
            self.blackViewProfileImage.transform = CGAffineTransform(
                translationX: self.mainTable.center.x - self.profileHeader.profileImage.bounds.width / 2,
                y: self.mainTable.center.y - self.profileHeader.profileImage.frame.height).scaledBy(x: scalilgFactor, y: scalilgFactor)

        }, completion: {_ in
            UIView.animate(withDuration: 0.3){
                self.blackViewCross.alpha = 1
            }
        })
    }

    @objc
    private func blackViewCrossTapAction(){
        UIView.animate(withDuration: 0.3, animations: {
            self.blackViewCross.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.blackViewProfileImage.transform = .identity
            }
        })
    }

    @objc
    private func changeAvatarCornerRadius(_ gesture: UIPinchGestureRecognizer){
        if gesture.state == .changed{
            let scale = min(gesture.scale - 0.5, 1)
            let cornerRadius = min((1 - scale) * 64, 64)
            profileHeader.profileImage.layer.cornerRadius = cornerRadius
            blackViewProfileImage.layer.cornerRadius = cornerRadius
        }
    }

    //MARK: - constraints
    func addConstraints(){
        [mainTable, blackView, blackViewProfileImage, blackViewCross].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            mainTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            blackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            blackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            blackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            blackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            blackViewProfileImage.topAnchor.constraint(equalTo: profileHeader.topAnchor, constant: 16),
            blackViewProfileImage.leftAnchor.constraint(equalTo: profileHeader.leftAnchor),
            blackViewProfileImage.heightAnchor.constraint(equalToConstant: 128),
            blackViewProfileImage.widthAnchor.constraint(equalTo: blackViewProfileImage.heightAnchor),

            blackViewCross.topAnchor.constraint(equalTo: blackView.topAnchor, constant: 10),
            blackViewCross.rightAnchor.constraint(equalTo: blackView.rightAnchor, constant: -10)

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
            viewModel.handleAction(.photosCellDidTap)
        }
    }
}

