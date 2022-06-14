//
//  MusicPlayerView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 12.06.2022.
//

import Foundation
import SwiftUI
import AVKit

@MainActor class MusicPlayerViewModel: ObservableObject{
    @Published var playingState: ActionButtonState = .disActive
    @Published var favoriteState: ActionButtonState = .disActive
    @Published var webState: ActionButtonState = .active
    @Published var rotationEffectRadius: CGFloat = 0.0
    @Published var player = AVQueuePlayer()
    
    
    let imageContentSize: CGFloat = 75.0.responsiveW
    let imagePlaceholderSize: CGFloat = 75.0.responsiveW
    
    func playButtonAction(songPreview: URL) -> Void{
        if playingState == .disActive{
            playingState = .inProgress
            Task{ @MainActor in
                player.removeAllItems()
                player.insert(AVPlayerItem(url: songPreview),after: nil)
                player.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                    self.playingState = .active
                    self.rotateView()
                }
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback)
                } catch(let error) {
                    print(error.localizedDescription)
                }
            }
        } else if playingState == .active{
            player.pause()
            player.removeAllItems()
            playingState = .disActive
            withAnimation {
                rotationEffectRadius = 0
            }
        }
    }
    
    func musicEndAction(){
        
    }
    
    func favoriteButtonAction() -> Void{
        withAnimation {
            if favoriteState == .active{
                favoriteState = .disActive
            }else{
                favoriteState = .active
            }
        }
    }
    
    private func rotateView(){
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
}
