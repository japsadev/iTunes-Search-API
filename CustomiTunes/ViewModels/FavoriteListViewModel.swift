//
//  FavoriteListViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 9.02.2022.
//

import Foundation

class FavoriteListClient : ObservableObject{
    let iTunesService = ItunesServices()
    @Published var favoriteSongs = [SongsExpandedViewModel]()
    
    let staticAppData = StaticAppData()
    let defaults = UserDefaults.standard

    func updateSongs(){
        self.favoriteSongs.removeAll()
        let favoriteList = self.defaults.object(forKey: "favoriteList") as? [Double] ?? []

        for songID in favoriteList {
            self.searchPopularSinger(for: songID)
        }
    }
    
    func searchPopularSinger(for songID : Double){
        iTunesService.searchByNameOrId(String(songID)) { (response) in
            switch response{
            case.failure(let error):
                print(error)
            case .success(let data):
                if let songResult = data as? [SongData]{
                    let song = songResult[0]
                    DispatchQueue.main.async {
                        self.favoriteSongs.append(
                            SongsExpandedViewModel(
                                id: song.id,
                                songName: song.wrappedTrackName,
                                singerName: song.wrappedArtistName,
                                trackExplicitness: song.wrappedTrackExplicitness,
                                songImage: song.middleImageURL
                            )
                        )
                    }
                }
            }
        }
    }
}
