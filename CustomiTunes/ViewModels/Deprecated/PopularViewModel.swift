//
//  PopularViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 22.01.2022.
//

import Foundation

@available(*, deprecated, message: "It will be soon move")
class PopularSongClient : ObservableObject{
    private let iTunesService = ItunesServices()
    @Published var popularSongs = [PopularViewModel]()
    let staticAppData = StaticAppData()
    
    init(contentKey: String?){
        guard var listKey = contentKey else { return }
        listKey = NSLocalizedString(listKey, comment: "for list name")
        
        if let songs = self.staticAppData.listsBySearchKey[listKey]{
            for song in songs {
                self.searchPopularSinger(for: song)
            }
        }
    }
    
    func searchPopularSinger(for singer : String){
        iTunesService.searchByNameOrId(singer, limit: 1) { (response) in
            switch response{
            case.failure(let error):
               print(error)
            case .success(let data):
                if let nonOData = data as? [SongData]{
                    for song in nonOData{
                        DispatchQueue.main.async {
                            self.popularSongs.append(
                                PopularViewModel(
                                    id: song.wrappedId,
                                    songName: song.wrappedTrackName,
                                    singerName: song.wrappedArtistName,
                                    trackExplicitness: song.wrappedTrackExplicitness,
                                    songImage: song.smallImageURL,
                                    artistID: song.artistId
                                )
                            )
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
    var trackExplicitness : String
    var songImage : URL
    var artistID : Double
}

struct PopularBigCardModel : Identifiable{
    var id = UUID()
    var contentKey : String
    var cardURL : URL
    var pageTitle : String
}
