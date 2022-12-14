//
//  ArtistDetailView - ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 20.06.2022.
//

import Foundation

@MainActor class ArtistDetailViewModel: ObservableObject{
    private let iTunesService: ItunesServices = ItunesServices()
    @Published var artistData: (name: String, image: URL)? = nil
    @Published var artistSongs: Array<SongData> = []
    @Published var pageState: PageLoadingState = .loading
    
    
    func getArtistSong(_ id: String){
        Task{ @MainActor in
            iTunesService.searchByNameOrId(id, limit: 50) { response in
                switch response{
                    
                case .success(let tracksData):
                    if var tracksData = tracksData as? [SongData]{
                        tracksData.remove(at: 0)
                        for song in tracksData{
                            DispatchQueue.main.async {
                                if song.wrappedTrackKind == "song"{
                                    self.checkSongIsAlreadyTaked(song)
                                }
                            }
                        }
                    }
                case .failure(_):
                    print("an error was taken on ArtistDetailViewModel")
                }
            }
        }
    }
    
    func getArtistData(_ id: String){
        Task{ @MainActor in
            iTunesService.searchByNameOrId(id, limit: 50, isAblum: true) { response in
                switch response{
                    
                case .success(let tracksData):
                    if let tracksData = tracksData as? [AlbumData]{
                        
                        DispatchQueue.main.async {
                            if !tracksData.isEmpty{
                                let firstSong = tracksData[1]
                                self.artistData = (name: firstSong.wrappedName, image: firstSong.wrappedArtistImage)
                                self.pageState = .successful
                            }
                        }
                    }
                case .failure(_):
                    self.pageState = .failed
                    print("an error was taken on ArtistDetailViewModel")
                }
            }
        }
    }
    
    func getDatas(_ id: Double){
        let stringId = String(id)
        self.getArtistData(stringId)
        self.getArtistSong(stringId)
    }
    
    func setPageTitle(_ artistName: String) -> String{
        NSLocalizedString("LOCAL_ARTIST_ALL_1", comment: "for localize artist name") + artistName + NSLocalizedString("LOCAL_ARTIST_ALL_2", comment: "for localize artist name")
    }
    
    func checkSongIsAlreadyTaked(_ song: SongData){
        var count = 0
        for compareSong in artistSongs{
            if song.wrappedId == compareSong.wrappedId{
                count += 1
            }else if song.wrappedTrackName == compareSong.wrappedTrackName{
                count += 1
            }
        }
        if count == 0{
            artistSongs.append(song)
        }
        artistSongs.sort{ $0.wrappedTrackName > $1.wrappedTrackName}
    }
    
}
