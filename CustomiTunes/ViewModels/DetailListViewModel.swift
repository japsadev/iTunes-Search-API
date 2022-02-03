//
//  DetailListViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 2.02.2022.
//

import Foundation


class DetailListSongClient : ObservableObject{
    let iTunesClient = ItunesClient()
    @Published var artistSongs = [DetailListViewModel]()
    
    func searchPopularSinger(for singer : String){
        
        
        iTunesClient.searchForName(for: singer , limit: 10) { (response) in
            switch response{
            case.failure(let error):
                print(error)
            case .success(let data):
                if let nonOData = data{
                    for song in nonOData{
                        DispatchQueue.main.async {
                            self.artistSongs.append(
                                DetailListViewModel(id: song.trackId!,
                                                 songName: song.trackName!,
                                                 singerName: song.artistName!,
                                                 trackExplicitness: song.trackExplicitness ?? "",
                                                 songImage: URL(string: song.artworkUrl250!)!
                                                )
                            )
                            self.artistSongs.shuffle()
                        }
                    }
                }
            }
        }
    }
}


struct DetailListViewModel : Identifiable{
    var id : Double
    var songName : String
    var singerName : String
    var trackExplicitness : String
    var songImage : URL
}
