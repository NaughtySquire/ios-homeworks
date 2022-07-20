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

    private lazy var contentView: UIView = {
        let view = UIView()
        view.alpha = 0
        return view
    }()

    private lazy var soundControllersContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()

    private lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.setImage(UIImage(systemName: "pause.fill"), for: .selected)
        button.tintColor = .white
        button.addAction(UIAction(handler: {[weak self] _ in
            self?.viewModel?.handleAction(.playPauseButtonTapped)
        }), for: .touchUpInside)
        return button
    }()

    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.tintColor = .white
        button.addAction(UIAction(handler: {[weak self] _ in
            self?.viewModel?.handleAction(.stopButtonTapped)
        }), for: .touchUpInside)
        return button
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.tintColor = .white
        button.addAction(UIAction(handler: {[weak self] _ in
            self?.viewModel?.handleAction(.nextButtonTapped)
        }), for: .touchUpInside)
        return button
    }()

    private lazy var previousButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        button.tintColor = .white
        button.addAction(UIAction(handler: {[weak self] _ in
            self?.viewModel?.handleAction(.previousButtonTapped)
        }), for: .touchUpInside)
        return button
    }()

    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()

    private lazy var soundsTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.layer.borderWidth = 2
        table.layer.borderColor = UIColor.systemBlue.cgColor
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return table
    }()

    private lazy var soundTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()


    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        addConstraints()
        setupViewModel()
    }

    // MARK: - functions

    func addSubviews(){
        self.view.addSubview(contentView)
        self.view.addSubview(loadingIndicatorView)

        [soundControllersContainerView, soundsTableView].forEach{
            self.contentView.addSubview($0)
        }

        [playPauseButton,
         stopButton,
         previousButton,
         nextButton,
         soundTitleLabel].forEach{
            self.soundControllersContainerView.addSubview($0)
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
                self?.updateSoundTitleLabel()
                self?.contentView.alpha = 1
			case .playing:
			    self?.playPauseButton.isSelected = true
                self?.updateSoundTitleLabel()
			case .paused:
			    self?.playPauseButton.isSelected = false
			case .stopped:
			    self?.playPauseButton.isSelected = false
            }
        }
    }

    func updateSoundTitleLabel(){
        guard let soundData = viewModel?.currentSoundData else{ return}
        let titleText = "\(soundData.artist) - \(soundData.name)"
        soundTitleLabel.text = titleText
    }

    // MARK: - constraints

    func addConstraints(){

        contentView.snp.makeConstraints{ maker in
            maker.left.top.right.bottom.equalToSuperview()
        }

        soundControllersContainerView.snp.makeConstraints{ maker in
            maker.left.right.centerY.equalToSuperview()
            maker.height.equalTo(30)
        }
        previousButton.snp.makeConstraints{ maker in
            maker.top.bottom.left.equalToSuperview()
            maker.width.equalTo(playPauseButton.snp.height)
        }
        playPauseButton.snp.makeConstraints{ maker in
            maker.top.bottom.equalToSuperview()
            maker.left.equalTo(previousButton.snp_rightMargin).offset(10)
            maker.width.equalTo(playPauseButton.snp.height)
        }
        stopButton.snp.makeConstraints{ maker in
            maker.top.bottom.equalToSuperview()
            maker.left.equalTo(playPauseButton.snp_rightMargin).offset(10)
            maker.width.equalTo(stopButton.snp.height)
        }
        nextButton.snp.makeConstraints{ maker in
            maker.top.bottom.equalToSuperview()
            maker.left.equalTo(stopButton.snp_rightMargin).offset(10)
            maker.width.equalTo(playPauseButton.snp.height)
        }
        loadingIndicatorView.snp.makeConstraints{ maker in
            maker.centerX.centerY.equalToSuperview()
        }
        soundsTableView.snp.makeConstraints{ maker in
            maker.top.equalTo(stopButton.snp_bottomMargin).offset(8)
            maker.left.right.bottom.equalToSuperview()
        }

        soundTitleLabel.snp.makeConstraints{ maker in
            maker.right.top.bottom.equalToSuperview()
            maker.left.equalTo(nextButton.snp_rightMargin).offset(8)

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
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemBlue.cgColor
        return cell
    }

}
