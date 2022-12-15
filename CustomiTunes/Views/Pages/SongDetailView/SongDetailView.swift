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
    var songId: Double

    var body: some View {
        Group {
            if viewModel.songIsAvaiable == .loading {
                VStack {
                    ProgressView()
                    Text("LOCAL_LOADING")
                }
            } else if viewModel.songIsAvaiable == .successful {
                let songData = viewModel.songData!
                ScrollView {
                    MusicPlayerView(songData: songData)
                        .padding(.bottom)
                    if viewModel.anotherSongsIsAvaible == .successful {
                        VStack(alignment: .leading) {
                            NavigationLink {
                                ArtistDetailView(artistID: songData.artistId)
                            } label: {
                                Text(viewModel.getLocalizedArtistName(artistName: songData.wrappedArtistName))
                                    .font(.title3)
                                    .lineLimit(1)
                            }.frame(width: 90.0.responsiveW, alignment: .leading)

                            ForEach(viewModel.otherArtistSongs, id: \.self?.wrappedId) {
                                ListSongView(songData: $0!)
                            }
                        }.padding(.bottom)
                    } else if viewModel.anotherSongsIsAvaible == .loading {
                        ProgressView()
                    } else if viewModel.anotherSongsIsAvaible == .failed {
                        Button("LOCAL_FAILED") {
                            viewModel.getAnotherSongsForArtist(for: songData.artistId)
                        }
                    }
                }.navigationTitle(songData.wrappedTrackName)
            } else {
                VStack {
                    Button("LOCAL_FAILED") {
                        viewModel.getSongDetail(songId)
                    }
                }
            }
        }.onAppear {
            viewModel.getSongDetail(songId)
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct SongDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        SongDetailView(songId: 1621475284.0)
    }
}
