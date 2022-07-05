//
//  LogInViewModel.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 01.07.2022.
//

import Foundation

class LogInViewModel: Coordinated{

    // MARK: - enums
    enum Action{
        case viewIsLoaded
        case logInButtonTapped(username: String, password: String)
    }
    enum State{
        case initial
        case loading
        case logInError
    }
    private var stateChanged: ((State)->())?
    private var state: State = .initial {
        didSet{
            stateChanged?(state)
        }
    }

    // MARK: - properties
    private let fetchService = FetchService()
    var coordinator: Coordinator

    // MARK: - init

    init(coordinator: LogInCoordinator){
        self.coordinator = coordinator
    }


    func chageState(_ action: Action){
        switch action {
        case .viewIsLoaded:
            state = .initial
        case .logInButtonTapped(username: let username, password: let password):
            state = .loading
            fetchService.fetchUser(username: username, password: password){[weak self] result in
                switch result{
                case .success(let model):
                    DispatchQueue.main.async {
                        (self?.coordinator as? LogInCoordinator)?.onFinish?(model, true)
                    }
                case .failure(_):
                    self?.state = .logInError
                }
            }
        }
    }
}
