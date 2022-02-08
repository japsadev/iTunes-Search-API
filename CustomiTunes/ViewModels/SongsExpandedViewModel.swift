//
//  SongsExpandedViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 9.02.2022.
//

import Foundation


class SongsExpandedClient : ObservableObject{
    let iTunesClient = ItunesClient()
    @Published var listSongs = [SongsExpandedViewModel]()

    let staticAppData = StaticAppData()
    
    init(contentKey: String?){
        guard var listKey = contentKey else { return }
        listKey = NSLocalizedString(listKey, comment: "for list name")
        listKey += "Expanded"
        
        if let songs = self.staticAppData.listsBySearchKey[listKey]{
            for song in songs {
                self.searchPopularSinger(for: song)
            }
        }
    }
    
    func hScroolKeyConventer(for localKey: String) -> String{
        return NSLocalizedString(localKey, comment: "for scrool list key")
    }
    
    func searchPopularSinger(for singer : String){
        iTunesClient.searchForName(for: singer , limit: 1) { (response) in
            switch response{
            case.failure(let error):
                print(error)
            case .success(let data):
                if let nonOData = data{
                    for song in nonOData{
                        DispatchQueue.main.async {
                            self.listSongs.append(
                                SongsExpandedViewModel(id: song.trackId!,
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
}

struct SongsExpandedViewModel : Identifiable{
    var id : Double
    var songName : String
    var singerName : String
    var trackExplicitness : String
    var songImage : URL
}
