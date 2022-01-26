//
//  PopularViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 22.01.2022.
//

import Foundation

class PopularSongClient : ObservableObject{
    let iTunesClient = ItunesClient()
    @Published var popularSongs = [PopularViewModel]()
    let popularSinger = ["rihanna" , "tate mcrae", "eminem" , "katy Perry" , "drake", "the weeknd" , "charlie puth" , "lisa" , "doja cat" , "imagine dragons" , "justin bieber"]
    init(){
        for singer in popularSinger {
            self.searchPopularSinger(for: singer)
        }
    }
    
    func searchPopularSinger(for singer : String){
        iTunesClient.search(for: singer) { (response) in
            switch response{
            case.failure(_):
               print("Hata")
            case .success(let data):
                if let nonOData = data{
                    for song in nonOData{
                        DispatchQueue.main.async {
                            self.popularSongs.append(
                                PopularViewModel(id: song.trackId!,
                                                 songName: song.trackName!,
                                                 singerName: song.artistName!,
                                                 songImage: URL(string: song.artworkUrl100!)!
                                                )
                            )
                            self.popularSongs.shuffle()
                        }
                    }
                }
            }
        }
    }
}

struct PopularViewModel : Identifiable{
    var id : Double
    var songName : String
    var singerName : String
    var songImage : URL
}
