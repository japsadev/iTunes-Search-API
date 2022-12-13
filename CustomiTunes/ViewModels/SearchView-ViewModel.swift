//
//  SearchView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 20.06.2022.
//

import Foundation

@MainActor class SearchViewModel: ObservableObject {
    private let iTunesService: ItunesServices = ItunesServices()
    let staticAppData = StaticAppData()
    @Published var searchResult: [SongData] = []
    @Published var searchKey: String = ""{
        didSet {
            searchTrackOrSinger()
        }
    }

    func searchTrackOrSinger() {
        DispatchQueue.main.async {
            self.searchResult.removeAll(keepingCapacity: true)
        }
        Task { @MainActor in
            iTunesService.searchByNameOrId(searchKey, limit: 10) { response in
                switch response {
                case .success(let trackData):
                    if let trackData = trackData as? [SongData] {
                        DispatchQueue.main.async {
                            self.searchResult = trackData
                        }
                    }
                case .failure:
                    print("an error was taked on SearchViewModel")
                }
            }
        }
    }
}
