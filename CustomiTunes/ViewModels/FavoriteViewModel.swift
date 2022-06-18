//
//  FavoriteViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 18.06.2022.
//

import Foundation

@MainActor class FavoriteViewModel: ObservableObject{
    @Published var favoriteTracks: Array<SongData> = []
    private var favoriteTracksIds: Array<Double> = []
    
    private let iTunesService = ItunesServices()
    private let saveKey = "favoriteTracks"
    
    init(){
        iTunesService.searchByNameOrId("Rihanna", limit: 10) { response in // example
            switch response{
                
            case .success(let tracksData):
                if let tracks = tracksData as? [SongData]{
                    DispatchQueue.main.async {
                        self.favoriteTracks = tracks
                    }
                }
            case .failure(_):
                print("an error was taken")
            }
        }
    }
    
    func saveFavorites(trackId: Double){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let fileURL = dir.appendingPathComponent(saveKey)
            
            do{
                if let encoded = try? JSONEncoder().encode(favoriteTracksIds) {
                    try encoded.write(to: fileURL)
                }
            } catch{ print("save error") }
        }
    }
    
    func readData(){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let fileURL = dir.appendingPathComponent(saveKey)
            
            do{
                let stringContent = try String(contentsOf: fileURL, encoding: .utf8)
                if let decoded = try? JSONDecoder().decode([Double].self, from: stringContent.data(using: .utf8) ?? Data()) {
                    self.favoriteTracksIds = decoded
                }
            } catch{ print("read error") }
        }
    }
}
