//
//  ProfileViewModel.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 09.07.2022.
//

class ProfileViewModel{
    enum Action{
        case photosCellDidTap
        case setStatusButtonDidTap(newStatus: String)
    }

    enum State{
        case initial
        case statusDidChange(_ newStatus: String)
    }
    // MARK: - properties
    var userData: UserData
    var goToPhotos: (() -> ())?
    var stateChanged: ((State)->())?

    // MARK: - init

    init(userData: UserData){
        self.userData = userData
    }

    // MARK: - functions
    private var state: State = .initial {
        didSet{
            stateChanged?(state)
        }
    }
    func handleAction(_ action: Action){
        switch action{
        case .photosCellDidTap:
            goToPhotos?()
        case .setStatusButtonDidTap(let newStatus):
            userData.status = newStatus
            state = .statusDidChange(userData.status)
        }
    }
}
