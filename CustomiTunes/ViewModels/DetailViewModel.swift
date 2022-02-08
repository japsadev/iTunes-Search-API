//
//  DetailViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 31.01.2022.
//

import Foundation
import SwiftUI

class DetailSongClient : ObservableObject{
    let iTunesClient = ItunesClient()
    @Published var detailedSong = DetailViewModel(id: 0, songName: "Name", singerName: "Singer", trackExplicitness: "", songImage: URL(string: "https://www.thewikifeed.com/wp-content/uploads/2021/09/tate-mcrae-1.jpg")!, songPreview: URL(string: "https://www.thewikifeed.com/wp-content/uploads/2021/09/tate-mcrae-1.jpg")!, artistID: 0, trackURL: URL(string: "https://www.thewikifeed.com/wp-content/uploads/2021/09/tate-mcrae-1.jpg")!)
    
    func getSong(for songID : Double){
        iTunesClient.detailForID(for: songID) { (response) in
            switch response{
            case.failure(_):
                print("ID hata")
            case.success(let data):
                if let song = data{
                    DispatchQueue.main.async {
                        self.detailedSong = DetailViewModel(
                            id: song.trackId!,
                            songName: song.trackName!,
                            singerName: song.artistName!,
                            trackExplicitness: song.trackExplicitness!,
                            songImage: URL(string: song.artworkUrl1000!)!,
                            songPreview: URL(string: song.previewUrl ?? "https://www.thewikifeed.com/wp-content/uploads/2021/09/tate-mcrae-1.jpg")!,
                            artistID: song.artistID!,
                            trackURL: URL(string: song.trackViewUrl!)!
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
