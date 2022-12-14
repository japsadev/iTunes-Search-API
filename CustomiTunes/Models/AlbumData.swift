//
//  UnHandledData.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 22.01.2022.
//

import Foundation

struct AlbumData: Codable {
    var wrappedName: String { artistName ?? "LOCAL_UNKNOWED" }
    var wrappedArtistImage: URL { URL(string: artworkUrl1000 ?? "https://www.thewikifeed.com/wp-content/uploads/2021/09/tate-mcrae-1.jpg")! }
    var wrapperType: String?
    var artistType: String?
    var artistLinkUrl: String?
    var amgArtistId: Double?
    var primaryGenreId: Double?
    var kind: String?
    var artistId: Double?
    var collectionId: Double?
    var trackId: Double?
    var artistName: String?
    var collectionName: String?
    var collectionType: String?
    var trackName: String?
    var collectionCensoredName: String?
    var trackCensoredName: String?
    var artistViewUrl: String?
    var collectionViewUrl: String?
    var trackViewUrl: String?
    var previewUrl: String?
    var artworkUrl30: String?
    var artworkUrl60: String?
    var artworkUrl100: String?
    var artworkUrl250: String? { artworkUrl100?.replacingOccurrences(of: "100x100", with: "250x250") }
    var artworkUrl1000: String? { artworkUrl100?.replacingOccurrences(of: "100x100", with: "1000x1000") }
    var collectionPrice: Double?
    var trackPrice: Double?
    var releaseDate: String?
    var collectionExplicitness: String?
    var trackExplicitness: String?
    var discCount: Int?
    var discNumber: Int?
    var trackCount: Int?
    var trackNumber: Int?
    var trackTimeMillis: Int?
    var country: String?
    var currency: String?
    var primaryGenreName: String?
    var contentAdvisoryRating: String?
    var isStreamable: Bool?
    var copyright: String?
}

struct SearchAlbumData: Codable {
    var resultCount: Int
    var results: [AlbumData]?
}
