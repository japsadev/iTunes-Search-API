//
//  SearchView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 20.06.2022.
//

import Foundation

@MainActor class SearchViewModel: ObservableObject {
    let staticAppData = StaticAppData()
    @Published var searchResult: [SongData] = []
    @Published var searchKey: String = "" {
        didSet {
            searchTrackOrSinger()
        }
    }

    func searchTrackOrSinger() {
        DispatchQueue.main.async {
            self.searchResult.removeAll(keepingCapacity: true)
        }
        Task { @MainActor in
            let service = ItunesServices<SearchSongData>()
            service.searchWithKey(searchKey) { response in
                switch response {
                case .success(let songs):
                    guard let songs = songs.results else { return }
                    DispatchQueue.main.async {
                        self.searchResult = songs
                    }
                case .failure:
                    print("an error was taked on SearchViewModel")
                }
            }
        }
    }
}
