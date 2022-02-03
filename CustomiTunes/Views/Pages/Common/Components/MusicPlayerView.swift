//
//  MusicPlayerView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 2.02.2022.
//

import SwiftUI
import AVFoundation

struct MusicPlayerView: View {
    var detailedSong : DetailViewModel
    @State private var rotation = 0.0
    @Environment(\.colorScheme) var colorScheme
    @State private var isPlayed = false
    @Binding var player : AVQueuePlayer
    
    var body: some View {
        AsyncImage(url: self.detailedSong.songImage) { image in
            VStack{
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75.0.responsiveW)
                    .clipShape(Circle())
                    .rotationEffect(.degrees(self.rotation))
                    .overlay(Circle().frame(width: 6.0.responsiveW, alignment: .center).foregroundColor(self.colorScheme == ColorScheme.dark ? .black : .white))
                    .shadow(radius: 5)
                HStack{
                    Spacer()
                    Button {
                        withAnimation {
                            self.isPlayed.toggle()
                        }
                        if isPlayed{
                            DispatchQueue.main.async {
                                player.removeAllItems()
                                player.insert(AVPlayerItem(url: self.detailedSong.songPreview),after: nil)
                                player.play()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                                self.isPlayed = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation(.linear(duration: 30)) {
                                    self.rotation = 360
                                }
                            }
                        }else{
                            self.player.removeAllItems()
                            withAnimation {
                                self.rotation = 0
                            }
                        }
                    } label: {
                        ZStack{
                            Circle()
                                .frame(width: 15.0.responsiveW,height: 15.0.responsiveW , alignment: .center)
                                .foregroundColor(.primary)
                            Image(systemName: self.isPlayed ? "pause" : "play")
                                .font(.title2)
                                .foregroundColor(.red)
                        }
                    }.offset(x:-30,y:-30)
                }
            }
        } placeholder: {
            VStack{
                Circle()
                    .foregroundColor(.secondary)
                    .overlay(ProgressView())
                    .frame(width: 75.0.responsiveW , height: 75.0.responsiveW)
                Spacer()
            }.frame(height: 90.0.responsiveW)
        }.frame(width: 90.0.responsiveW)
            .onDisappear {
                withAnimation {
                    self.rotation = 0
                }
            }
    }
}
