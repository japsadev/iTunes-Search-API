//
//  FavoriteViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 18.06.2022.
//

import Foundation

@MainActor class FavoriteViewModel: ObservableObject{
    @Published var favoriteTracks: Array<SongData> = []
    @Published var accountSheet: Bool = false
    @Published var pageState: PageLoadingState = .loading
    
    private let iTunesService = ItunesServices()

    func getFavoriteTracks(tracks: Array<Double>){
        favoriteTracks.removeAll(keepingCapacity: true)
        for trackId in tracks {
            getOneTrack(trackId)
        }
        self.pageState = .successful
    }
    
    func getOneTrack(_ id: Double){
        Task{ @MainActor in
            iTunesService.searchByNameOrId(String(id)) { response in
                switch response{
                    
                case .success(let tracksData):
                    if let tracks = tracksData as? [SongData?]{
                        if let track = tracks[0]{
                            DispatchQueue.main.async {
                                self.favoriteTracks.append(track)
                            }
                        }
                    }
                case .failure(_):
                    self.pageState = .failed
                    print("an error was taken")
                }
            }
        }
    }
}
