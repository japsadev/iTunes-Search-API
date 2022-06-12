//
//  DetailViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 31.01.2022.
//

import Foundation
import SwiftUI

class DetailSongClient : ObservableObject{
    private let iTunesService = ItunesServices()
    @Published var detailedSong = DetailViewModel(id: 0, songName: "Name", singerName: "Singer", trackExplicitness: "", songImage: URL(string: "https://www.thewikifeed.com/wp-content/uploads/2021/09/tate-mcrae-1.jpg")!, songPreview: URL(string: "https://www.thewikifeed.com/wp-content/uploads/2021/09/tate-mcrae-1.jpg")!, artistID: 0, trackURL: URL(string: "https://www.thewikifeed.com/wp-content/uploads/2021/09/tate-mcrae-1.jpg")!)
    
    func getSong(for songID : Double){
        iTunesService.searchByNameOrId(String(songID)) { (response) in
            switch response{
            case.failure(_):
                print("ID hata")
            case.success(let data):
                if let songList = data as? [SongData]{
                    let song = songList[0]
                    DispatchQueue.main.async {
                        self.detailedSong = DetailViewModel(
                            id: song.id,
                            songName: song.wrappedTrackName,
                            singerName: song.wrappedArtistName,
                            trackExplicitness: song.wrappedTrackExplicitness,
                            songImage: song.bigImageURL,
                            songPreview: song.wrappedTrackPreview,
                            artistID: song.artistID,
                            trackURL: song.wrappedTrackViewURL
                        )
                    }
                }
            }
        }
    }
    
    func getLocalizedText(for singer : String , with localKey : String) -> String{
        let key = NSLocalizedString(localKey, comment: "for county code")
        
        switch key{
        case "TR":
            return singer + NSLocalizedString("LOCAL_MORE_THAN", comment: "for order")
        case "US":
            return NSLocalizedString("LOCAL_MORE_THAN", comment: "for order") + singer
        default :
            return NSLocalizedString("LOCAL_MORE_THAN", comment: "for order") + singer
        }
    }
}


struct DetailViewModel : Identifiable{
    var id : Double
    var songName : String
    var singerName : String
    var trackExplicitness : String
    var songImage : URL
    var songPreview : URL
    var artistID : Double
    var trackURL : URL
}
