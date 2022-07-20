//
//  PlayerViewModel.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 19.07.2022.
//

import Foundation
import AVFoundation

class PlayerViewModel{
    enum Action{
        case playPauseButtonTapped
        case stopButtonTapped
        case nextButtonTapped
        case previousButtonTapped
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
    var currentSoundData: SoundData?
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
        DispatchQueue.global().async {
            self.state = .loading
            self.setupUserSoundsData(self.username)
            self.setupCurrentSound(0)
            self.setupPlayer()
        }
    }

    // MARK: - functions

    func handleAction(_ action: Action){
        switch action{
        case .playPauseButtonTapped:
            playOrPausePlayer()
        case .stopButtonTapped:
            stopPlayer()
        case .nextButtonTapped:
            stopPlayer()
            setupNextSound()
            setupPlayer()
            playOrPausePlayer()
        case .previousButtonTapped:
            stopPlayer()
            setupPreviousSound()
            setupPlayer()
            playOrPausePlayer()
        case.soundCellSelected(let index):
            self.state = .stopped
            stopPlayer()
            setupCurrentSound(index)
            setupPlayer()
            playOrPausePlayer()
        }
    }

    private func playOrPausePlayer(){
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

    private func setupUserSoundsData(_ username: String){
        fetchService.fetchSoundsUserData(username){ [weak self] result in
            switch result{
            case .success(let model):
                self?.soundsUserData = model
                self?.currentSoundData = model[0]
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
        let path = Bundle.main.path(forResource: currentSound!.url,
                                    ofType: currentSound!.fileExtension)
        let soundUrl = URL(fileURLWithPath: path ?? "")
        do{
            try player = AVAudioPlayer(contentsOf: soundUrl)
            player?.prepareToPlay()
        }catch{
            print(error)
        }
    }

    private func setupCurrentSound(_ soundIndex: Int){
        self.fetchService.fetchSound(artist: (self.soundsUserData?[soundIndex].artist),
                                     name: (self.soundsUserData?[soundIndex].name),
                                     completion: { [weak self] result in
            switch result{
            case .success(let model):
                self?.currentSound = model
                self?.currentSoundData = self?.soundsUserData?[soundIndex]
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

    private func setupNextSound(){
        guard let soundsUserData = soundsUserData,
              let currentSoundIndex = soundsUserData.firstIndex(where: {
            $0.artist == currentSoundData?.artist && $0.name == currentSoundData?.name
        })else { return }
        guard currentSoundIndex != soundsUserData.count - 1 else { return}
        setupCurrentSound(currentSoundIndex + 1)
    }

    private func setupPreviousSound(){
        guard let soundsUserData = soundsUserData,
              let currentSoundIndex = soundsUserData.firstIndex(where: {
            $0.artist == currentSoundData?.artist && $0.name == currentSoundData?.name
        })else { return }
        guard currentSoundIndex != 0 else { return}
        setupCurrentSound(currentSoundIndex - 1)
    }

}
