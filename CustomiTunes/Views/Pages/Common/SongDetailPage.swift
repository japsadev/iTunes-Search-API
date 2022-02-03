//
//  SongDetailPage.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 31.01.2022.
//

import SwiftUI
import AVFoundation


struct SongDetailPage: View {
    private var detailSongId : Double
    
    @ObservedObject private var pageClient = DetailSongClient()
    @ObservedObject private var moreThanClient = DetailListSongClient()
    @Environment(\.colorScheme) var colorScheme
    @State var player = AVQueuePlayer()
    
    init (detailSongId : Double){
        self.detailSongId = detailSongId
        self.pageClient.getSong(for: detailSongId)
    }
    
    var body: some View {
        ScrollView{
            if self.pageClient.detailedSong.id == 0{
                Rectangle()
                    .frame(width: 90.0.responsiveW, height: 90.0.responsiveW, alignment: .center)
            }else{
                MusicPlayerView(detailedSong: self.pageClient.detailedSong, player: self.$player)
                VStack{
                    HStack{
                        Text("More than " + self.pageClient.detailedSong.singerName)
                            .font(.title)
                        Spacer()
                    }
                    if self.moreThanClient.artistSongs.isEmpty{
                        ProgressView()
                    }else{
                        ForEach(self.moreThanClient.artistSongs) {
                            song in ListSongView(listSong: song)
                        }
                    }
                    
                }.offset(y:-30)
                    .padding(.horizontal)
                    .onAppear {
                        self.moreThanClient.searchPopularSinger(for: self.pageClient.detailedSong.singerName)
                    }
            }
        }.navigationBarTitleDisplayMode(.inline)
        .navigationTitle(self.pageClient.detailedSong.songName)
        .onDisappear {
            self.player.removeAllItems()
        }
    }
}

struct SongDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        SongDetailPage(detailSongId: 1598031515.0)
    }
}


