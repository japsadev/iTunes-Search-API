//
//  PopularViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 22.01.2022.
//

import Foundation

class PopularSongClient : ObservableObject{
    let iTunesClient = ItunesClient()
    @Published var popularSongs = [PopularViewModel]()
    @Published var popularContentUrls = [
        "https://is4-ssl.mzstatic.com/image/thumb/Features116/v4/2f/70/c2/2f70c28e-a20f-1df9-a5e5-12496db08033/U0gtTVMtV1ctWmlydmVkZWtpbGVyX1R1zIhya2PMp2VfTWFiZWxfTWF0aXotMDEyODIyLnBuZw.png/1000x611sr-60.jpg",
        "https://is2-ssl.mzstatic.com/image/thumb/Features116/v4/bc/ee/a2/bceea2d5-507e-ae7c-8da4-fc984cb8b8e5/source/1000x611sr-60.jpg",
        "https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/f2/b4/e0/f2b4e016-0fc1-6ec9-57f5-504350639b59/U0gtTVMtV1ctUHVzdWxhX0NvbG9yXzIwMjEucG5n.png/1000x611sr-60.jpg",
        "https://is4-ssl.mzstatic.com/image/thumb/Features126/v4/66/b8/a3/66b8a357-24a3-bc75-a922-e7fb10a4a8d0/U0gtTVMtV1ctU1BBVElBTC1UaXRsZS5wbmc.png/1000x611sr-60.jpg",
        "https://is2-ssl.mzstatic.com/image/thumb/Features116/v4/05/45/df/0545df70-f1b1-39ff-361b-78b8ee1fbd55/VTBndFRWTXRWRlZTTFVkdnpJaHJjMlZzTFVoaGEyekVzWGxreExGdVgxTnBibWRzWlM1d2JtYy5wbmc.png/1000x611sr-60.jpg",
        "https://is4-ssl.mzstatic.com/image/thumb/Features126/v4/db/60/2f/db602fd4-e638-55a1-e749-cc9f35c44d11/source/1000x611sr-60.jpg"
        
    ]
    let songs = [
        "wish i loved you in the 90s",
        "Bul Beni",
        "Bilmem mi?",
        "Alaz Alaz",
        "Blinding Lights",
        "Ariyorum",
        "Dunyanin En Guzel Kizi",
        "Pare",
        "1 gr eksik",
        "Easy On Me",
        "Kim",
        "Bonita",
        "Bad Habits",
        "You Right",
        "Sevmedim Deme",
        "Seveni Bul Da Gel",
        "late at night",
        "Retrograde(Galantis Remix)",
        "Gravity Glidin",
        "Astronaut in The Ocean",
        "Higher Power",
        "EveryTime I Cry",
        "By Your Side",
        "Marlon Brando",
        "Our Song",
        "Kanunlar Gibi",
    ]
    init(){
        for song in songs {
            self.searchPopularSinger(for: song)
        }
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
                            self.popularSongs.append(
                                PopularViewModel(id: song.trackId!,
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

struct PopularViewModel : Identifiable{
    var id : Double
    var songName : String
    var singerName : String
    var trackExplicitness : String
    var songImage : URL
}
