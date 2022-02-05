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
        "firstScrool" : [
            PopularBigCardModel(contentKey: "turkeySongs", cardURL: URL(string: "https://is2-ssl.mzstatic.com/image/thumb/Features116/v4/52/e8/92/52e892b0-0e16-cc91-ffd6-85b41c2c51a4/U0gtTVMtV1ctWmlydmVkZWtpbGVyX1R1zIhya2PMp2UtUG9wLUVjZV9TZWPMp2tpbi0wMjA0MjIucG5n.png/1000x611sr-60.jpg")!),
            PopularBigCardModel(contentKey: "globalSongs", cardURL: URL(string: "https://is4-ssl.mzstatic.com/image/thumb/Features126/v4/ed/ae/e4/edaee4bb-9446-ac49-feab-07286b5ef4d4/source/1000x611sr-60.jpg")!),
        ],
        "secondScrool" : [
            PopularBigCardModel(contentKey: "globalSongs", cardURL: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/09/07/69/09076916-8bc1-0b1a-2efe-9f9d01f4add1/VTBndFRWTXRWRlZTTFVWalpWOVRaV1BNcDJ0cGJpMVRaVzVmU0dGc1lWOVBjbVJoYzhTeGJsOVRhVzVuYkdVdWNHNW4ucG5n.png/1000x611sr-60.jpg")!),
            PopularBigCardModel(contentKey: "globalSongs", cardURL: URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/f2/b4/e0/f2b4e016-0fc1-6ec9-57f5-504350639b59/U0gtTVMtV1ctUHVzdWxhX0NvbG9yXzIwMjEucG5n.png/1000x611sr-60.jpg")!),
        ]
    ]
    
    let listsBySearchKey = [
        "turkeySongs" : [
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
        ],
        "globalSongs" : [
            "Do We Have A Problem?",
            "she's all i wanna be",
            "Super Gremlin",
            "We don't talk about bruno",
            "hrs and hrs",
            "STAY",
            "don't play that",
            "cigarettes",
            "Easy On Me",
            "P power",
            "abcdefu",
            "Heat Waves",
            "Lost",
            "Surface Pressure",
            "i hate u",
            "shivers",
            "knife talk",
            "cold heart(PNAU Remix)",
            "Fingers Crossed",
            "Bad Habits",
            "INDUSTRY BABY",
            "oh my god",
            "rumors",
            "blinding lights",
            "woman",
        ]
    ]
    
    
    init(contentKey: String?){
        if let songs = self.listsBySearchKey[contentKey ?? ""]{
            for song in songs {
                self.searchPopularSinger(for: song)
            }
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

struct PopularBigCardModel : Identifiable{
    var id = UUID()
    var contentKey : String
    var cardURL : URL
}
