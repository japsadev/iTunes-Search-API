//
//  PopularView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 14.06.2022.
//

import Foundation

@MainActor class PopularViewModel2: ObservableObject{ // TODO: Change this view model's name "PopularViewModel" after delete old view model
    @Published var songsByKey: [String : [SongData]] = [:]
    
    private let iTunesService = ItunesServices()
    let staticAppDatas = StaticAppData()
    
    func getCards(_ key: String) -> Array<(contentKey: String, cardURL: URL, pageTitle: String)>{
        staticAppDatas.popularContentUrls[key.keyToLocalizedValue()] ?? []
    }
    
    func getTracksByKey(_ key: String){
        let songSearchKeys = staticAppDatas.listsBySearchKey[key.keyToLocalizedValue()] ?? []
        for songSearchKey in songSearchKeys {
            getTrackBySearchKey(for: songSearchKey, by: key)
        }
    }
    
    private func getTrackBySearchKey(for key: String, by listKey: String){
        Task{ @MainActor in
            iTunesService.searchByNameOrId(key, limit: 1) { response in
                switch response{
                    
                case .success(let trackDatas):
                    if let trackDatas = trackDatas as? [SongData?]{
                        if let trackData = trackDatas[0]{
                            DispatchQueue.main.async {
                                var trackList = self.songsByKey[listKey] ?? []
                                if trackList.contains(where: { $0.id == trackData.wrappedId }){
                                    // track already added the list
                                }else{
                                    trackList.append(trackData)
                                    self.songsByKey[listKey] = trackList
                                }
                            }
                        }
                    }
                    
                case .failure(_):
                    print("an error was taked")
                }
            }
        }
    }
}
