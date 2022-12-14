//
//  ArtistDetailView - ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 20.06.2022.
//

import Foundation

@MainActor class ArtistDetailViewModel: ObservableObject {
    @Published var artistData: (name: String, image: URL)?
    @Published var artistSongs: [SongData] = []
    @Published var pageState: PageLoadingState = .loading

    func getArtistSong(_ id: String) {
        Task { @MainActor in
            let service = ItunesServices<SearchSongData>()
            service.searchWithKey(id, limit: 50) { response in
                switch response {
                case .success(let songs):
                    guard var songs = songs.results else { return }
                    songs.removeFirst()
                    for song in songs {
                        DispatchQueue.main.async {
                            if song.wrappedTrackKind == "song" {
                                self.checkSongIsAlreadyTaked(song)
                            }
                        }
                    }
                case .failure:
                    print("an error was taken on ArtistDetailViewModel")
                }
            }
        }
    }

    func getArtistData(_ id: String) {
        Task { @MainActor in
            let service = ItunesServices<SearchAlbumData>()
            service.searchWithKey(id, limit: 50) { response in
                switch response {
                case .success(var albums):
                    guard let albums = albums.results else { return }
                    DispatchQueue.main.async {
                        if !albums.isEmpty {
                            let firstAlbum = albums[1]
                            self.artistData = (name: firstAlbum.wrappedName, image: firstAlbum.wrappedArtistImage)
                            self.pageState = .successful
                        }
                    }
                case .failure:
                    self.pageState = .failed
                    print("an error was taken on ArtistDetailViewModel")
                }
            }
        }
    }

    func getDatas(_ id: Double) {
        let stringId = String(id)
        self.getArtistData(stringId)
        self.getArtistSong(stringId)
    }

    func setPageTitle(_ artistName: String) -> String {
        NSLocalizedString("LOCAL_ARTIST_ALL_1", comment: "for localize artist name") + artistName + NSLocalizedString("LOCAL_ARTIST_ALL_2", comment: "for localize artist name")
    }

    func checkSongIsAlreadyTaked(_ song: SongData) {
        var count = 0
        for compareSong in artistSongs {
            if song.wrappedId == compareSong.wrappedId {
                count += 1
            } else if song.wrappedTrackName == compareSong.wrappedTrackName {
                count += 1
            }
        }
        if count == 0 {
            artistSongs.append(song)
        }
        artistSongs.sort { $0.wrappedTrackName > $1.wrappedTrackName }
    }
}
