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
    var viewModel: PlayerViewModel? = PlayerViewModel(username: "wolk")

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

    // MARK: - init



    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        addConstraints()
    }

    // MARK: - handlers
    
    @objc
    func playPauseButtonTapped(_ button: UIButton){
        if button.isSelected{
            viewModel?.handleAction(.pauseButtonTapped)
            button.isSelected = false
        }else{
            viewModel?.handleAction(.playButtonTapped)
            button.isSelected = true
        }
    }

    @objc
    func stopButtonTapped(){
        self.playPauseButton.isSelected  = false
        viewModel?.handleAction(.stopButtonTapped)
    }

    // MARK: - functions

    func addSubviews(){
        [playPauseButton, stopButton].forEach{
            self.soundControllersContainerView.addSubview($0)
        }
        [soundControllersContainerView].forEach{
            self.view.addSubview($0)
        }
    }

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
    }
}
