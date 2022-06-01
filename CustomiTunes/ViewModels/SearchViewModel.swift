//
//  SearchViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 5.02.2022.
//

import Foundation

class SearchViewClient : ObservableObject{
    
    @Published var searchResult = [SearchViewModel]()
    let iTunesClient = ItunesClient()
    
    func getSearchResult(for searchKey : String){
        self.iTunesClient.searchForName(for: searchKey, limit: 20) { searchResult in
            switch searchResult{
            case .failure(let error):
                print(error)
            case .success(let data):
                if let nonOData = data{
                    for song in nonOData{
                        DispatchQueue.main.async {
                            self.searchResult.append(
                                SearchViewModel(id: song.trackId!,
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


struct SearchViewModel : Identifiable{
    var id : Double
    var songName : String
    var singerName : String
    var trackExplicitness : String
    var songImage : URL
}
