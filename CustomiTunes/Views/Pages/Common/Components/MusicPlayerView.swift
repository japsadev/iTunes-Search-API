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
    @State var rotation = 0.0
    @Environment(\.colorScheme) var colorScheme
    @State private var isPlayed = false
    @State private var isFavorite = false
    @State private var isWebView = false
    @Binding var player : AVQueuePlayer
    @ObservedObject private var favoriteClient = FavoriteListClient()
    
    @State var favoriteList = [Double](){
        didSet{
            self.isFavorite = favoriteList.contains(self.detailedSong.id)
        }
    }
    let defaults = UserDefaults.standard
    
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
                    ActionButtonView(buttonAction: {
                        withAnimation {
                            if isFavorite{
                                self.favoriteList.remove(at: self.favoriteList.firstIndex(of: self.detailedSong.id)!)
                            }else{
                                self.favoriteList.append(self.detailedSong.id)
                            }
                            self.defaults.set(self.favoriteList, forKey: "favoriteList")
                            self.favoriteClient.updateSongs()
                        }
                    }, isValue: self.$isFavorite, activeIcon: "heart.fill", disActiveIcon: "heart", disActiveTitle: "LOCAL_FAVORITE_DEACTIVE", activeTitle: "LOCAL_FAVORITE_ACTIVE")
                    
                    ActionButtonView(buttonAction: {
                        withAnimation {
                            self.isPlayed.toggle()
                        }
                        if isPlayed{
                            DispatchQueue.main.async {
                                player.removeAllItems()
                                player.insert(AVPlayerItem(url: self.detailedSong.songPreview),after: nil)
                                do {
                                    try AVAudioSession.sharedInstance().setCategory(.playback)
                                } catch(let error) {
                                    print(error.localizedDescription)
                                }
                                player.play()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                                self.isPlayed = false
                                self.rotation = 0
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
                    }, isValue: self.$isPlayed, activeIcon: "pause", disActiveIcon: "play", disActiveTitle: "LOCAL_PLAY", activeTitle: "LOCAL_PAUSE")
                    
                    ActionButtonView(buttonAction: {
                        self.isWebView.toggle()
                    }, isValue: self.$isWebView, activeIcon: "safari", disActiveIcon: "safari", disActiveTitle: "LOCAL_WEB_VIEW", activeTitle: "LOCAL_WEB_VIEW")
                        .sheet(isPresented: self.$isWebView, onDismiss: nil) {
                            WebView(url: self.detailedSong.trackURL)
                        }

                        
                }.padding(.top,10)
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
                self.isPlayed = false
            }.onAppear {
                self.favoriteList = self.defaults.object(forKey: "favoriteList") as? [Double] ?? []
            }
            
    }
}

struct MusicPlayerView_Preview: PreviewProvider {
    static var previews: some View {
        SongDetailView(detailSongId: 1598031515.0)
    }
}



