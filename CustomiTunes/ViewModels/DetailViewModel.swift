//
//  DetailViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 31.01.2022.
//

import Foundation

class DetailSongClient : ObservableObject{
    let iTunesClient = ItunesClient()
    @Published var detailedSong = DetailViewModel(id: 0.0, songName: "Song Name", singerName: "Singer Name", trackExplicitness: "exclipt", songImage: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png")!)
    
    func getSong(for songID : Double){
        iTunesClient.detailForID(for: songID) { (response) in
            switch response{
            case.failure(_):
                print("ID hata")
            case.success(let data):
                if let song = data{
                    DispatchQueue.main.async {
                        self.detailedSong = DetailViewModel(id: song.trackId!, songName: song.trackName!, singerName: song.artistName!, trackExplicitness: song.trackExplicitness!, songImage: URL(string: song.artworkUrl1000!)!)
                    }
                }
            }
        }
    }
}


struct DetailViewModel : Identifiable{
    var id : Double
    var songName : String
    var singerName : String
    var trackExplicitness : String
    var songImage : URL
}
