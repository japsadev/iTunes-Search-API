//
//  SongDetailView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 12.06.2022.
//

import Foundation
import AVKit

@MainActor class SongDetailViewModel: ObservableObject {
    @Published var songData: SongData?
    @Published var otherArtistSongs: [SongData?] = []
    @Published var songIsAvaiable: PageLoadingState = .loading
    @Published var anotherSongsIsAvaible: PageLoadingState = .loading

    func getSongDetail(_ id: Double) {
        Task { @MainActor in
            let service = ItunesServices<SearchSongData>()
            service.searchWithKey(String(id)) { response in
                switch response {
                case .success(let songs):
                    guard let songs = songs.results else { return }
                    if !songs.isEmpty {
                        DispatchQueue.main.async { [weak self] in
                            guard let self, let song = songs.first else { return }
                            self.songData = song
                            self.getAnotherSongsForArtist(for: song.artistId)
                            self.songIsAvaiable = .successful
                        }
                    } else {
                        self.songIsAvaiable = .failed
                    }
                case .failure:
                    self.songIsAvaiable = .failed
                }
            }
        }
    }

    func getAnotherSongsForArtist(for singerID: Double) {
        Task { @MainActor in
            let service = ItunesServices<SearchSongData>()
            service.searchWithKey(String(singerID)) { response in
                switch response {
                case .success(let songs):
                    guard var songs = songs.results else { return }
                    songs.remove(at: 0)
                    for song in songs {
                        DispatchQueue.main.async {
                            if song.wrappedTrackKind == "song" {
                                self.checkSongIsAlreadyTaked(song)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.anotherSongsIsAvaible = .successful
                    }
                case .failure:
                    self.anotherSongsIsAvaible = .failed
                }
            }
        }
    }

    func checkSongIsAlreadyTaked(_ song: SongData) {
        var count = 0
        for compareSong in otherArtistSongs {
            if song.wrappedId == compareSong?.wrappedId {
                count += 1
            } else if song.wrappedTrackName == compareSong?.wrappedTrackName {
                count += 1
            }
        }
        if count == 0 {
            otherArtistSongs.append(song)
        }
        otherArtistSongs.sort { $0!.wrappedTrackName > $1!.wrappedTrackName }
    }

    func getLocalizedArtistName(artistName: String) -> String {
        let key = NSLocalizedString("LOCAL_CODE", comment: "for county code")
        switch key {
        case "TR":
            return artistName + NSLocalizedString("LOCAL_MORE_THAN", comment: "for order")
        case "US":
            return NSLocalizedString("LOCAL_MORE_THAN", comment: "for order") + artistName
        default:
            return NSLocalizedString("LOCAL_MORE_THAN", comment: "for order") + artistName
        }
    }
}
