//
//  PopularView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 14.06.2022.
//

import Foundation

@MainActor class PopularViewModel: ObservableObject {
    @Published var songsByKey: [String: [SongData]] = [:]
    let staticAppDatas = StaticAppData()

    func getCards(_ key: String) -> [(contentKey: String, cardURL: URL, pageTitle: String)] {
        staticAppDatas.popularContentUrls[key.keyToLocalizedValue()] ?? []
    }

    func getTracksByKey(_ key: String) {
        let songSearchKeys = staticAppDatas.listsBySearchKey[key.keyToLocalizedValue()] ?? []
        for songSearchKey in songSearchKeys {
            getTrackBySearchKey(for: songSearchKey, by: key)
        }
    }

    private func getTrackBySearchKey(for key: String, by listKey: String) {
        Task { @MainActor in
            let service = ItunesServices<SearchSongData>()
            service.searchWithKey(key, limit: 1) { response in
                switch response {
                case .success(let songs):
                    if let song = songs.results?.first {
                        DispatchQueue.main.async {
                            var songList = self.songsByKey[listKey] ?? []
                            if !songList.contains(where: { $0.wrappedId == song.wrappedId }) {
                                songList.append(song)
                                self.songsByKey[listKey] = songList
                            }
                        }
                    }
                case .failure:
                    print("an error was taked")
                }
            }
        }
    }
}
