//
//  SongDetailView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 12.06.2022.
//

import Foundation
import AVKit

@MainActor class SongDetailViewModel: ObservableObject {
    private let requestService: ItunesServices = ItunesServices()

    @Published var songData: SongData?
    @Published var otherArtistSongs: [SongData?] = []
    @Published var songIsAvaiable: PageLoadingState = .loading
    @Published var anotherSongsIsAvaible: PageLoadingState = .loading

    func getSongDetail(_ id: Double) {
        Task { @MainActor in
            requestService.searchByNameOrId(String(id)) { requestResponse in
                switch requestResponse {
                case .success(let songData):
                    if let songData = songData as? [SongData] {
                        if !songData.isEmpty {
                            DispatchQueue.main.async {
                                self.songData = songData[0]
                                self.getAnotherSongsForArtist(for: songData[0].artistId)
                                self.songIsAvaiable = .successful
                            }
                        } else {
                            self.songIsAvaiable = .failed
                        }
                    }
                case .failure:
                    self.songIsAvaiable = .failed
                }
            }
        }
    }

    func getAnotherSongsForArtist(for singerID: Double) {
        Task { @MainActor in
            requestService.searchByNameOrId(String(singerID), limit: 20) { (response) in
                switch response {
                case.failure:
                    DispatchQueue.main.async {
                        self.anotherSongsIsAvaible = .failed
                    }
                case .success(let songsData):
                    if var songsData = songsData as? [SongData] {
                        songsData.remove(at: 0)
                        for song in songsData {
                            DispatchQueue.main.async {
                                if song.wrappedTrackKind == "song" {
                                    self.checkSongIsAlreadyTaked(song)
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.anotherSongsIsAvaible = .successful
                        }
                    }
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
