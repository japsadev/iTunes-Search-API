//
//  SongData.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 11.02.2022.
//

import Foundation

struct SongData: Codable {
    // MARK: Wrapped Properties (Useful properties on views)
    var trackId: Double?
    var wrappedId: Double { trackId ?? -1 }
    var artistId: Double
    var wrappedTrackName: String { trackName ?? "LOCAL_UNKNOWED" }
    var wrappedArtistName: String { artistName ?? "LOCAL_UNKNOWED" }
    var wrappedTrackExplicitness: String { trackExplicitness ?? "" }
    var wrappedTrackKind: String { kind ?? "LOCAL_UNKNOWED" }
    var wrappedArtistViewURL: URL { URL(string: artistViewUrl ?? "https://www.apple.com")! }
    var wrappedTrackViewURL: URL { URL(string: trackViewUrl ?? "https://www.apple.com")! }
    var wrappedTrackPreview: URL { URL(string: previewUrl ?? "https://www.apple.com")! }
    var bigImageURL: URL { URL(string: artworkUrl1000 ?? "https://www.thewikifeed.com/wp-content/uploads/2021/09/tate-mcrae-1.jpg")! }
    var middleImageURL: URL { URL(string: artworkUrl250 ?? "https://www.thewikifeed.com/wp-content/uploads/2021/09/tate-mcrae-1.jpg")! }
    var smallImageURL: URL { URL(string: artworkUrl100 ?? "https://www.thewikifeed.com/wp-content/uploads/2021/09/tate-mcrae-1.jpg")! }

    // MARK: Handled Properties
    private var wrapperType: String?
    private var kind: String?
    private var collectionId: Double?
    private var artistName: String?
    private var collectionName: String?
    private var trackName: String?
    private var collectionCensoredName: String?
    private var trackCensoredName: String?
    private var artistViewUrl: String?
    private var collectionViewUrl: String?
    private var trackViewUrl: String?
    private var previewUrl: String?
    private var artworkUrl30: String?
    private var artworkUrl60: String?
    private var artworkUrl100: String?
    private var artworkUrl250: String? { artworkUrl100?.replacingOccurrences(of: "100x100", with: "250x250") }
    private var artworkUrl1000: String? { artworkUrl100?.replacingOccurrences(of: "100x100", with: "1000x1000") }
    private var collectionPrice: Double?
    private var trackPrice: Double?
    private var releaseDate: String?
    private var collectionExplicitness: String?
    private var trackExplicitness: String?
    private var discCount: Int?
    private var discNumber: Int?
    private var trackCount: Int?
    private var trackNumber: Int?
    private var trackTimeMillis: Int?
    private var country: String?
    private var currency: String?
    private var primaryGenreName: String?
    private var contentAdvisoryRating: String?
    private var isStreamable: Bool?
}

struct SearchSongData: Codable {
    var resultCount: Int
    var results: [SongData]?
}
