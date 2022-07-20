//
//  PlayerViewModel.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 19.07.2022.
//

import Foundation
import AVFoundation

class PlayerViewModel{
    enum Action: Equatable{
        case playPauseButtonTapped
        case stopButtonTapped
        case soundCellSelected(index: Int)
    }

    enum State{
        case initial
        case loading
        case loaded
        case playing
        case paused
        case stopped
    }

    // MARK: - properties

    var player: AVAudioPlayer?
    var soundsUserData: [SoundData]?
    var currentSound: Sound?
    var fetchService = FetchService()
    let username: String
    var stateChanged: ((_ state: State) -> ())?

    var state: State = .initial {
        didSet{
            DispatchQueue.main.async {
                self.stateChanged?(self.state)
            }
        }
    }

    // MARK: - init

    init(username: String){
        self.username = username
        self.state = .loading
        DispatchQueue.global().async {
            self.setupUserSoundsData(self.username)
            self.setupCurrentSound(0)
            self.setupPlayer()
        }
    }

    // MARK: - functions

    func handleAction(_ action: Action){
        switch action{
        case .playPauseButtonTapped:
            playPausePlayer()
        case .stopButtonTapped:
            stopPlayer()
        case.soundCellSelected(let index):
            self.state = .stopped
            stopPlayer()
            setupCurrentSound(index)
            setupPlayer()
            playPausePlayer()
        }
    }

    private func setupUserSoundsData(_ username: String){
        fetchService.fetchSoundsUserData(username){ [weak self] result in
            switch result{
            case .success(let model):
                self?.soundsUserData = model
                self?.state = .loaded
            case .failure(let error):
                switch error{
                case .fetchError:
                    self?.setupUserSoundsData(username)
                    print(error)
                case .noInputData:
                    print(error)
                case .noOutputData:
                    print(error)
                }
            }
        }
    }

    private func setupPlayer(){
        let soundUrl = URL(fileURLWithPath: Bundle.main.path(forResource: currentSound!.url,
                                                             ofType: currentSound!.fileExtension)!)
        do{
            try player = AVAudioPlayer(contentsOf: soundUrl)
        }catch{
            print(error)
        }
    }

    private func playPausePlayer(){
        if let player = player {
            if player.isPlaying{
                player.pause()
                state = .paused
            }else{
                player.play()
                state = .playing
            }
            return
        }
    }

    private func stopPlayer(){
        guard let player = player  else{ return }
        player.stop()
        player.currentTime = 0
        state = .stopped
    }

    private func setupCurrentSound(_ soundIndex: Int){
        self.fetchService.fetchSound(artist: (self.soundsUserData?[soundIndex].artist),
                                     name: (self.soundsUserData?[soundIndex].name),
                                     completion: { [weak self] result in
            switch result{
            case .success(let model):
                self?.currentSound = model

            case .failure(let error):
                switch error{
                case .fetchError:
                    self?.setupCurrentSound(soundIndex)
                    print(error)
                case .noInputData:
                    print(error)
                case .noOutputData:
                    print(error)
                }
            }
        })
    }
}

