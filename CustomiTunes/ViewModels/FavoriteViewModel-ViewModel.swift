//
//  FavoriteViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 18.06.2022.
//

import Foundation

@MainActor class FavoriteViewModel: ObservableObject {
    @Published var favoriteTracks: [SongData] = []
    @Published var accountSheet: Bool = false
    @Published var pageState: PageLoadingState = .loading

    func getFavoriteTracks(tracks: [Double]) {
        favoriteTracks.removeAll(keepingCapacity: true)
        for trackId in tracks {
            getOneTrack(trackId)
        }
        self.pageState = .successful
    }

    func getOneTrack(_ id: Double) {
        Task { @MainActor in
            let service = ItunesServices<SearchSongData>()
            service.searchWithKey(String(id)) { response in
                switch response {
                case .success(let songs):
                    if let song = songs.results?.first {
                        DispatchQueue.main.async {
                            self.favoriteTracks.append(song)
                        }
                    }
                case .failure:
                    self.pageState = .failed
                    print("an error was taken")
                }
            }
        }
    }
}
