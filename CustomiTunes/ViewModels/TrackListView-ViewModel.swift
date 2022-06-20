//
//  TrackListView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 20.06.2022.
//

import Foundation

@MainActor class TrackListViewModel: ObservableObject{
    @Published var pageState: PageLoadingState = .loading
    private let staticAppData = StaticAppData()
    private let iTunesService = ItunesServices()
    
    @Published var trackList: Array<SongData> = []

    func getListTracks(by key: String){
        let localizedKey = NSLocalizedString(key, comment: "Localized Key") + "Expanded"
        let trackList = staticAppData.listsBySearchKey[localizedKey] ?? []
        for track in trackList{
            getSongByName(track)
        }
        self.pageState = .successful
    }
    
    func getSongByName(_ name: String){
        Task{ @MainActor in
            self.iTunesService.searchByNameOrId(name){ response in
                switch response{
                    
                case .success(let trackList):
                    if let trackList = trackList as? [SongData]{
                        let track = trackList[0]
                        DispatchQueue.main.async {
                            self.trackList.append(track)
                        }
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.pageState = .failed
                    }
                    print("an error was taked trackList")
                }
            }
        }
    }
}
