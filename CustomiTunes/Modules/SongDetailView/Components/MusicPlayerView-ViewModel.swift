//
//  MusicPlayerView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 12.06.2022.
//

import Foundation
import SwiftUI
import AVKit

@MainActor class MusicPlayerViewModel: ObservableObject {
    @Published var playingState: ActionButtonState = .disActive
    @Published var favoriteState: ActionButtonState = .disActive
    @Published var webState: ActionButtonState = .active
    @Published var rotationEffectRadius: CGFloat = 0.0
    @Published var player = AVQueuePlayer()

    let imageContentSize: CGFloat = 75.0.responsiveW
    let imagePlaceholderSize: CGFloat = 75.0.responsiveW

    func playButtonAction(songPreview: URL) {
        if playingState == .disActive {
            playingState = .inProgress
            Task { @MainActor in
                DispatchQueue.main.async {
                    self.player.removeAllItems()
                    self.player.insert(AVPlayerItem(url: songPreview), after: nil)
                    self.player.play()
                    self.playingState = .active
                    self.rotateView()
                }
                try? AVAudioSession.sharedInstance().setCategory(.playback)
            }
        } else if playingState == .active {
            player.pause()
            player.removeAllItems()
            playingState = .disActive
            withAnimation {
                rotationEffectRadius = 0
            }
        }
    }

    func favoriteButtonAction() {
        withAnimation {
            if favoriteState == .active {
                favoriteState = .disActive
            } else {
                favoriteState = .active
            }
        }
    }

    private func rotateView() {
        withAnimation(.linear(duration: 30)) {
            rotationEffectRadius = 360.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.rotationEffectRadius = 0
            withAnimation {
                self.playingState = .disActive
            }
        }
    }

    func setFavoriteButtonState(state: Bool) {
        withAnimation {
            if state {
                favoriteState = .active
            } else {
                favoriteState = .disActive
            }
        }
    }
}
