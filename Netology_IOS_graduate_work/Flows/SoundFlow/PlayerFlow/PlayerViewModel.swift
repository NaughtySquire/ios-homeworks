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
        case playButtonTapped
        case pauseButtonTapped
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
    var soundsUserData: [UserSoundData]?
    var currentSound: Sound?
    var fetchService = FetchService()
    let username: String
    var stateChanged: ((_ state: State) -> ())?

    var state: State = .initial {
        didSet{
            stateChanged?(state)
        }
    }

    // MARK: - init

    init(username: String){
        state = .loading
        self.username = username
        let setupUserSoundsDataWorkItem = DispatchWorkItem{
            self.setupUserSoundsData(self.username)
        }
        setupUserSoundsDataWorkItem.notify(queue: .global(qos: .userInitiated)){
            self.state = .loaded
            self.setupCurrentSound(0)
        }
        DispatchQueue.global(qos: .userInteractive).async {
            setupUserSoundsDataWorkItem.perform()
        }
    }

    // MARK: - functions

    func handleAction(_ action: Action){
        guard let currentSound = self.currentSound else {
            return
        }
        switch action{
        case .playButtonTapped:
            self.state = .playing
            let soundUrl = URL(fileURLWithPath: Bundle.main.path(forResource: currentSound.url,
                                                                 ofType: currentSound.fileExtension)!)
            if let player = self.player{
                player.play()
                return
            }
            do{
                self.player = try AVAudioPlayer(contentsOf: soundUrl)
                self.player!.play()
            }catch{
                print(error)
            }
        case .pauseButtonTapped:
            self.state = .paused
            self.player?.pause()

        case .stopButtonTapped:
            self.state = .stopped
            self.player?.stop()
            self.player?.currentTime = 0

        case.soundCellSelected(let index):
            self.player?.stop()
            setupCurrentSound(index)
        }
    }

    private func setupUserSoundsData(_ username: String){
        fetchService.fetchSoundsUserData(username){ [weak self] result in
            switch result{
            case .success(let model):
                self?.state = .loaded
                self?.soundsUserData = model
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

    private func setupCurrentSound(_ soundIndex: Int){
        self.fetchService.fetchSound(artist: (self.soundsUserData?[soundIndex].artist),
                                     name: (self.soundsUserData?[soundIndex].name),
                                     completion: { [weak self] result in
            switch result{
            case .success(let model):
                self?.currentSound = model
                let soundUrl = URL(fileURLWithPath: Bundle.main.path(forResource: self?.currentSound!.url,
                                                                     ofType: self?.currentSound!.fileExtension)!)
                do{
                    self?.player = try AVAudioPlayer(contentsOf: soundUrl)
                } catch{
                    print(error)
                }
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

