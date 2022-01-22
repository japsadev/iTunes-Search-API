//
//  FavoriteViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 22.01.2022.
//

import Foundation

class FavoriteClient : ObservableObject{
    @Published var songName : String
    let iTunesClient = ItunesClient()
    
    init(){
        
    }
    
    func getPopular(){
        iTunesClient.search(for: "rihanna") { (response) in
            switch response{
            case.success(let data):
                if let nonOData = data{
                    for song in nonOData{
                        self.songName = song.trackName ?? ""
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


class PopularClient

