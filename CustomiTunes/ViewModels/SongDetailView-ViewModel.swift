//
//  SongDetailView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 12.06.2022.
//

import Foundation
import AVKit

@MainActor class SongDetailViewModel: ObservableObject{
    private let requestService: ItunesServices = ItunesServices()
    
    @Published var songData: SongData?
    @Published var otherArtistSongs: Array<SongData?> = []
    @Published var songIsAvaiable: PageLoadingState = .loading
    @Published var anotherSongsIsAvaible: PageLoadingState = .loading
    
    func getSongDetail(_ id: Double){
        Task{ @MainActor in
            requestService.searchByNameOrId(String(id)) { requestResponse in
                switch requestResponse{
                case .success(let _songData):
                    if let _songData = _songData as? [SongData] {
                        if !_songData.isEmpty{
                            DispatchQueue.main.async {
                                self.songData = _songData[0]
                                self.getAnotherSongsForArtist(for: _songData[0].artistId)
                                self.songIsAvaiable = .successful
                            }
                        }else{
                            self.songIsAvaiable = .failed
                        }
                    }
                case .failure(_):
                    self.songIsAvaiable = .failed
                }
            }
        }
    }
    
    func getAnotherSongsForArtist(for singerID: Double){
        Task{ @MainActor in
            requestService.searchByNameOrId(String(singerID), limit: 20) { (response) in
                switch response{
                case.failure(_):
                    DispatchQueue.main.async {
                        self.anotherSongsIsAvaible = .failed
                    }
                case .success(let _songsData):
                    if var _songsData  = _songsData as? [SongData]{
                        _songsData.remove(at: 0)
                        for song in _songsData{
                            DispatchQueue.main.async {
                                if song.wrappedTrackKind == "song"{
                                    self.checkSongIsAlreadyTaked(song)
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.anotherSongsIsAvaible = .successful
                        }
                    }
                }
            }
        }
    }
    
    func checkSongIsAlreadyTaked(_ song: SongData){
        var count = 0
        for compareSong in otherArtistSongs{
            if song.id == compareSong?.id{
                count += 1
            }else if song.wrappedTrackName == compareSong?.wrappedTrackName{
                count += 1
            }
        }
        if count == 0{
            otherArtistSongs.append(song)
        }
        otherArtistSongs.sort{ $0!.wrappedTrackName > $1!.wrappedTrackName}
    }
}

