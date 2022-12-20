//
//  TrackListView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 20.06.2022.
//

import Foundation

@MainActor class TrackListViewModel: ObservableObject {
    @Published var pageState: PageLoadingState = .loading
    @Published var trackList: [SongData] = []

    func getListTracks(by key: String) {
        let localizedKey = NSLocalizedString(key, comment: "Localized Key") + "Expanded"
        let trackList = AppConstants.shared.listsBySearchKey[localizedKey] ?? []
        for track in trackList {
            getSongByName(track)
        }
        self.pageState = .successful
    }

    func getSongByName(_ name: String) {
        Task { @MainActor in
            let service = ItunesServices<SearchSongData>()
            service.searchWithKey(name) { response in
                switch response {
                case .success(let songs):
                    guard let song = songs.results?.first else { return }
                    DispatchQueue.main.async {
                        self.trackList.append(song)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.pageState = .failed
                    }
                    print("an error was taked trackList")
                }
            }
        }
    }
}
