//
//  SongDetailPage.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 31.01.2022.
//

import SwiftUI
import AVFoundation
import UIKit


struct SongDetailView: View {
    @StateObject private var viewModel: SongDetailViewModel = SongDetailViewModel()
    private var songId: Double
//    @ObservedObject private var pageClient = DetailSongClient()
//    @ObservedObject private var moreThanClient = DetailListSongClient()
//    @State var player = AVQueuePlayer()
//    @State private var isHide = false
    
    init (detailSongId : Double){
        self.songId = detailSongId
    }
    
    var body: some View {
        Group{
            if viewModel.songIsAvaiable == .loading{
                VStack{
                    ProgressView()
                    Text("LOCAL_LOADING")
                }
            }else if viewModel.songIsAvaiable == .successful{
                let songData = viewModel.songData!
                ScrollView{
                    MusicPlayerView(songData: songData)
                    if viewModel.anotherSongsIsAvaible == .successful{
                        VStack{
                            ForEach(viewModel.otherArtistSongs, id: \.self?.id){
                                Text($0!.wrappedTrackName)
                            }
                        }
                    }else if viewModel.anotherSongsIsAvaible == .loading{
                        ProgressView()
                    }else if viewModel.anotherSongsIsAvaible == .failed{
                        Button("LOCAL_FAILED"){
                            viewModel.getAnotherSongsForArtist(for: songData.artistId)
                        }
                    }
                }.navigationTitle(songData.wrappedTrackName)
            }else{
                VStack{
                    Button("LOCAL_FAILED"){
                        viewModel.getSongDetail(songId)
                    }
                }
            }
        }.onAppear{
            viewModel.getSongDetail(songId)
        }.navigationBarTitleDisplayMode(.inline)

//        ScrollView{
//            if self.pageClient.detailedSong.id == 0{
//                Rectangle()
//                    .frame(width: 90.0.responsiveW, height: 90.0.responsiveW, alignment: .center)
//            }else{
////                MusicPlayerView(detailedSong: self.pageClient.detailedSong, player: self.$player)
//                VStack{
//                    HStack{
//                        NavigationLink {
//                            ArtistDetailView(artistID: self.pageClient.detailedSong.artistID, artistName: self.pageClient.detailedSong.singerName)
//                        } label: {
//                            Text(self.pageClient.getLocalizedText(for: self.pageClient.detailedSong.singerName, with: "LOCAL_CODE"))
//                                .font(.title)
//                                .lineLimit(1)
//                        }
//                        Spacer()
//                    }
//                    if self.moreThanClient.artistSongs.isEmpty{
//                        ProgressView()
//                    }else{
//                        ForEach(self.moreThanClient.artistSongs) {
//                            song in ListSongView(listSong: song)
//                        }
//                    }
//                }.padding(.horizontal)
//                    .onAppear {
//                        self.moreThanClient.searchBySingerID(for: self.pageClient.detailedSong.artistID,limit: 10)
//                    }
//            }
//        }.navigationBarTitleDisplayMode(.inline)
//            .toolbar{
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        let shareMusic = UIActivityViewController(activityItems: [self.pageClient.detailedSong.trackURL], applicationActivities: nil)
//                        if let vc = UIApplication.shared.windows.first?.rootViewController{
//                            vc.present(shareMusic,animated: true)
//                        }
//                    } label: {
//                        Image(systemName: "square.and.arrow.up")
//                    }
//                }
//            }
//            .navigationTitle(self.pageClient.detailedSong.songName)
//            .onDisappear {
//                self.player.removeAllItems()
//            }
    }
}

struct SongDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        SongDetailView(detailSongId: 1621475284.0)
    }
}


