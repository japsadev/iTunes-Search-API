//
//  SearchViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 5.02.2022.
//

import Foundation

@available(*, deprecated, message: "It will be soon move")
class SearchViewClient : ObservableObject{
    @Published var searchResult = [SearchViewModel]()
    private let iTunesService = ItunesServices()
    
    func getSearchResult(for searchKey : String){
        iTunesService.searchByNameOrId(searchKey, limit: 20) { searchResult in
            switch searchResult{
            case .failure(let error):
                print(error)
            case .success(let data):
                if let nonOData = data as? [SongData]{
                    for song in nonOData{
                        DispatchQueue.main.async {
                            self.searchResult.append(
                                SearchViewModel(id: song.wrappedId,
                                                songName: song.wrappedTrackName,
                                                artistName: song.wrappedArtistName,
                                                trackExplicitness: song.wrappedTrackExplicitness,
                                                songImage: song.smallImageURL
                                               )
                            )
                        }
                        
                    }
                }
            }
        }
    }
    
}


struct SearchViewModel : Identifiable{
    var id : Double
    var songName : String
    var artistName : String
    var trackExplicitness : String
    var songImage : URL
}
