//
//  Enums.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 20.12.2022.
//

enum DownloadError: Error {
    case wrongUrl(url: String)
    case unload(url: String)
    case unbuild(url: String)
}

enum PageLoadingState {
    case loading
    case failed
    case successful
    case disable
}
