//
//  MusicViewController.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 16.07.2022.
//

import UIKit
import AVFoundation
import SnapKit

class PlayerViewController: UIViewController {

    // MARK: - properties
    var viewModel: PlayerViewModel?
    let cellIdentifier = "cell"

    // MARK: - views

    private lazy var soundControllersContainerView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.setImage(UIImage(systemName: "pause.fill"), for: .selected)
        button.addTarget(self, action: #selector(playPauseButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        button.imageView?.contentMode = .scaleToFill
        return button
    }()

    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()

    private lazy var soundsTableView: UITableView = {
        let table = UITableView()
        table.alpha = 0
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return table
    }()

    // MARK: - init



    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        addConstraints()
        setupViewModel()
    }

    // MARK: - handlers
    
    @objc
    func playPauseButtonTapped(_ button: UIButton){
        viewModel?.handleAction(.playPauseButtonTapped)
    }

    @objc
    func stopButtonTapped(){
        viewModel?.handleAction(.stopButtonTapped)
    }

    // MARK: - functions

    func addSubviews(){
        [playPauseButton, stopButton].forEach{
            self.soundControllersContainerView.addSubview($0)
        }
        [soundControllersContainerView, loadingIndicatorView, soundsTableView].forEach{
            self.view.addSubview($0)
        }
    }

    func setupViewModel(){
        viewModel = PlayerViewModel(username: "wolk")
        self.viewModel?.stateChanged = { [weak self] state in
			switch state{
			case .initial:
			    ()
			case .loading:
			    self?.loadingIndicatorView.startAnimating()
			case .loaded:
			    self?.loadingIndicatorView.stopAnimating()
			    self?.soundsTableView.reloadData()
			    self?.soundsTableView.alpha = 1
			case .playing:
			    self?.playPauseButton.isSelected = true
			case .paused:
			    self?.playPauseButton.isSelected = false
			case .stopped:
			    self?.playPauseButton.isSelected = false
            }
        }
    }

    // MARK: - constraints

    func addConstraints(){

        soundControllersContainerView.snp.makeConstraints{ maker in
            maker.left.right.centerY.equalToSuperview()
            maker.height.equalTo(50)
        }
        playPauseButton.snp.makeConstraints{ maker in
            maker.top.bottom.equalToSuperview()
            maker.centerX.equalTo(self.view).offset(-30)
            maker.width.equalTo(playPauseButton.snp.height)
        }
        stopButton.snp.makeConstraints{ maker in
            maker.top.bottom.equalToSuperview()
            maker.left.equalTo(playPauseButton.snp_rightMargin).offset(10)
            maker.width.equalTo(stopButton.snp.height)
        }
        loadingIndicatorView.snp.makeConstraints{ maker in
            maker.top.equalTo(stopButton.snp_bottomMargin).offset(10)
            maker.centerX.equalToSuperview()
        }
        soundsTableView.snp.makeConstraints{ maker in
            maker.top.equalTo(stopButton.snp_bottomMargin).offset(10)
            maker.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - extension - TableViewDelegate
extension PlayerViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.handleAction(.soundCellSelected(index: indexPath.row))
    }
}
// MARK: - extension - TableViewDataSource
extension PlayerViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.soundsUserData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        let soundData = viewModel?.soundsUserData?[indexPath.row]
        content.text = "\(soundData?.artist ?? "") - \(soundData?.name ?? "")"
        cell.contentConfiguration = content
        return cell
    }

}
