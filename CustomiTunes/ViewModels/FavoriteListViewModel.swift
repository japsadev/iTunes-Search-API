//
//  FavoriteListViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 9.02.2022.
//

import Foundation

class FavoriteListClient : ObservableObject{
    let iTunesClient = ItunesClient()
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
        iTunesClient.detailForID(for: songID) { (response) in
            switch response{
            case.failure(let error):
                print(error)
            case .success(let data):
                if let song = data{
                    DispatchQueue.main.async {
                        self.favoriteSongs.append(
                            SongsExpandedViewModel(
                                id: song.trackId!,
                                songName: song.trackName!,
                                singerName: song.artistName!,
                                trackExplicitness: song.trackExplicitness ?? "",
                                songImage: URL(string: song.artworkUrl250!)!
                            )
                        )
                    }
                }
            }
        }
    }
}
