//
//  ArtistDetailViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 9.02.2022.
//

import Foundation

class ArtistDetailClient : ObservableObject{
    private let iTunesService = ItunesServices()
    @Published var artistSongs = [DetailListViewModel]()
    @Published var artistAlbum = [ArtistDetailViewModel]()
    
    func getArtistImage(for ID : Double){
        iTunesService.searchByNameOrId(String(ID)) { (response) in
            switch response{
            case.failure(let error):
                print(error)
            case.success(let data):
                if let albums = data as? [AlbumData]{
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

struct ArtistDetailViewModel : Identifiable{
    var id = UUID()
    var artistImage : URL
}
