//
//  PopularView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 14.06.2022.
//

import Foundation

@MainActor class PopularViewModel2: ObservableObject{ // TODO: Change this view model's name "PopularViewModel" after delete old view model
    private let iTunesService = ItunesServices()
    let staticAppDatas = StaticAppData()
    
    func getCards(_ key: String) -> Array<(contentKey: String, cardURL: URL, pageTitle: String)>{
        staticAppDatas.popularContentUrls[key.keyToLocalizedValue()] ?? []
    }
}
