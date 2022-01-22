//
//  PopularViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 22.01.2022.
//

import Foundation

class PopularViewClient : ObservableObject{
    var songs = [PopularViewModel]()
    let iTunesClient = ItunesClient()
    
    init(){
        self.iTunesClient.search(for: "tate mcrae") { (response) in
            switch response{
            case.success(let resData):
                if let nonOData = resData{
                    for song in nonOData{
                        self.songs.append(PopularViewModel(id: song.trackId!, songName: song.trackName ?? "Track Name", singerName: song.artistName ?? "Artist Name"))
                    }
                }
            case .failure(let error):
                self.songs.append(PopularViewModel(id:0,songName: "Bir Hata Oluştu", singerName: "Daha Sonra Tekrar Deneyiniz"))
            }
        }
    }
}


struct PopularViewModel : Identifiable{
    var id : Double
    var songName : String
    var singerName : String
}
