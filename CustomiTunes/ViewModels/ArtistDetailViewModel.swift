//
//  ArtistDetailViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 9.02.2022.
//

import Foundation

class ArtistDetailClient : ObservableObject{
    let iTunesClient = ItunesClient()
    @Published var artistSongs = [DetailListViewModel]()
    @Published var artistAlbum = [ArtistDetailViewModel]()
    
    func getArtistImage(for ID : Double){
        iTunesClient.artistAlbumsForArtistID(for: ID) { (response) in
            switch response{
            case.failure(let error):
                print(error)
            case.success(let data):
                if let albums = data{
                    DispatchQueue.main.async {
                        for (index,album) in albums.enumerated() {
                            if index == 0{
                                continue
                            }
                            self.artistAlbum.append(ArtistDetailViewModel(
                                artistImage: URL(string: album.artworkUrl1000 ?? "https://ichef.bbci.co.uk/news/1024/cpsprodpb/C218/production/_117688694_croppedpressimage3.jpg")!
                            ))
                        }
                    }
                }
            }
        }
    }
    
    func searchBySingerID(for singerID : Double, limit : Int){
        iTunesClient.searchForSingerID(for: singerID , limit: limit) { (response) in
            switch response{
            case.failure(let error):
                print(error)
            case .success(let data):
                if let nonOData = data{
                    for song in nonOData{
                        DispatchQueue.main.async {
                            if song.kind == "song"{
                                var count = 0
                                for compareSong in self.artistSongs{
                                    if song.trackId == compareSong.id{
                                        count += 1
                                    }else if song.trackName == compareSong.songName{
                                        count += 1
                                    }
                                }
                                if count == 0{
                                    self.artistSongs.append(
                                        DetailListViewModel(
                                            id: song.trackId!,
                                            songName: song.trackName!,
                                            singerName: song.artistName!,
                                            trackExplicitness: song.trackExplicitness ?? "",
                                            songImage: URL(string: song.artworkUrl250!)!,
                                            artistPreview: URL(string: song.artistViewUrl ?? "https://ichef.bbci.co.uk/news/1024/cpsprodpb/C218/production/_117688694_croppedpressimage3.jpg")!
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

struct ArtistDetailViewModel : Identifiable{
    var id = UUID()
    var artistImage : URL
}
