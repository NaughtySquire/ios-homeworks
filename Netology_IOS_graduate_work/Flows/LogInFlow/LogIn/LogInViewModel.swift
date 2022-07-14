//
//  LogInViewModel.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 01.07.2022.
//

import Foundation

class LogInViewModel{

    // MARK: - enums
    enum Action{
        case viewIsLoaded
        case logInButtonTapped(username: String, password: String)
    }
    enum State{
        case initial
        case loading
        case logInError
        case connectionError
    }
    var stateChanged: ((State)->())?
    private var state: State = .initial {
        didSet{
            stateChanged?(state)
        }
    }

    // MARK: - properties
    private let fetchService = FetchService()
    var loggedIn: ((UserData, Bool) -> ())?
    var showAllert: ((String) -> ())?

    // MARK: - functions
    func handleAction(_ action: Action){
        switch action {
        case .viewIsLoaded:
            state = .initial
        case .logInButtonTapped(username: let username, password: let password):
            state = .loading
            fetchService.getUser(username: username, password: password){[weak self] result in
                DispatchQueue.main.async {
                	switch result{
                	case .success(let model):
                        self?.loggedIn?(model, true)
                	case .failure(let fetchError):
                        self?.handleError(fetchError: fetchError)
                    }
                }
            }
        }
    }

    func handleError(fetchError: FetchError){
        switch fetchError{
        case .authError:
            self.state = .logInError
            showAllert?("Ошибка авторизации")
        case .connectionError:
            self.state = .connectionError
            showAllert?("Интернет недоступен")
        }
    }
}
