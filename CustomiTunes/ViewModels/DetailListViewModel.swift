//
//  DetailListViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 2.02.2022.
//

import Foundation


class DetailListSongClient : ObservableObject{
    let iTunesService = ItunesServices()
    @Published var artistSongs = [DetailListViewModel]()
    
    func searchBySingerID(for singerID : Double, limit : Int){
        iTunesService.searchByNameOrId(String(singerID), limit: limit) { (response) in
            switch response{
            case.failure(let error):
                print(error)
            case .success(let data):
                if let nonOData = data as? [SongData]{
                    for song in nonOData{
                        DispatchQueue.main.async {
                            if song.wrappedTrackKind == "song"{
                                var count = 0
                                for compareSong in self.artistSongs{
                                    if song.id == compareSong.id{
                                        count += 1
                                    }else if song.wrappedTrackName == compareSong.trackName{
                                        count += 1
                                    }
                                }
                                if count == 0{
                                    self.artistSongs.append(
                                        DetailListViewModel(
                                            id: song.id,
                                            trackName: song.wrappedTrackName,
                                            artistName: song.wrappedArtistName,
                                            trackExplicitness: song.wrappedTrackExplicitness,
                                            trackImage: song.bigImageURL,
                                            artistPreview: song.wrappedArtistViewURL
                                        )
                                    )
                                }
                            }
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
    var trackName : String
    var artistName : String
    var trackExplicitness : String
    var trackImage : URL
    var artistPreview : URL
}
