//
//  SoundViewController.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 16.07.2022.
//

import UIKit
import SnapKit

class SoundViewController: UIViewController {

    // MARK: - properties


    let factory = ModuleFactory()
    let controllersTitles = ["Проигрыватель", "Диктофон"]
    var adapter: PageViewControllerSegmentedAdapter!

    // MARK: - child controllers

    private lazy var controllers = [PlayerViewController(),
                                    RecorderViewController()]

    // MARK: - views

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var soundOperationPageControl: UISegmentedControl = {
        let control = UISegmentedControl()
        for title in controllersTitles{
            control.insertSegment(withTitle: title, at: controllers.count - 1, animated: true)
        }
        control.backgroundColor = .white
        control.layer.borderColor = UIColor.blue.cgColor
        control.selectedSegmentIndex = 0
        return control
    }()

    private lazy var soundOperationsPageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll,
                                          navigationOrientation: .horizontal)
        pageVC.setViewControllers([controllers.first!],
                                  direction: .forward,
                                  animated: true)
        return pageVC
    }()

    // MARK: - lify cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
        addSubviews()
        addConstraints()
    }
    
    // MARK: - functions
    func setupPageViewController(){
        self.addChild(soundOperationsPageViewController)
        soundOperationsPageViewController.didMove(toParent: self)
        adapter = PageViewControllerSegmentedAdapter(pageViewController: soundOperationsPageViewController, segmentControl: soundOperationPageControl, viewControllers: controllers)

    }

    func addSubviews(){
        [contentView, soundOperationPageControl].forEach{
            self.view.addSubview($0)
        }
        contentView.addSubview(soundOperationsPageViewController.view)
    }

    func addConstraints(){

        contentView.snp.makeConstraints{ maker in
            maker.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            maker.top.equalTo(soundOperationPageControl.snp_bottomMargin)
        }

        soundOperationsPageViewController.view?.snp.makeConstraints{ maker in
            maker.left.top.right.bottom.equalToSuperview()
        }

        soundOperationPageControl.snp.makeConstraints{ maker in
            maker.left.right.top.equalTo(view.safeAreaLayoutGuide)
            maker.height.equalTo(50)
        }
    }
}

