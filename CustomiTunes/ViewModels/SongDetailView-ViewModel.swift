//
//  SongDetailView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 12.06.2022.
//

import Foundation

@MainActor class SongDetailViewModel: ObservableObject{
    let requestService: ItunesServices = ItunesServices()
    
    @Published var songData: SongData?
    @Published var songIsAvaiable: Bool = true
    
    func getSongDetail(_ id: Double){
        Task{ @MainActor in
            requestService.searchByNameOrId(String(id)) { requestResponse in
                switch requestResponse{
                case .success(let _songData):
                    if let _songData = _songData as? [SongData] {
                        if !_songData.isEmpty{
                            DispatchQueue.main.async {
                                self.songData = _songData[0]
                            }
                        }else{
                            
                        }
                    }
                case .failure(_):
                    self.songIsAvaiable = false
                }
            }
        }
    }
}

