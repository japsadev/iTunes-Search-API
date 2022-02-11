//
//  SongData.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 11.02.2022.
//

import Foundation

struct SongData : Codable {
    var wrapperType : String?
    var kind : String?
    var artistID : Double?
    var collectionId : Double?
    var trackId : Double?
    var artistName : String?
    var collectionName : String?
    var trackName : String?
    var collectionCensoredName : String?
    var trackCensoredName : String?
    var artistViewUrl : String?
    var collectionViewUrl : String?
    var trackViewUrl : String?
    var previewUrl : String?
    var artworkUrl30 : String?
    var artworkUrl60 : String?
    var artworkUrl100 : String?
    var artworkUrl250 : String?{
        if let artworkUrl100 = artworkUrl100 {
            return artworkUrl100.replacingOccurrences(of: "100x100", with: "250x250")
        }else{
            return nil
        }
    }
    var artworkUrl1000 : String?{
        if let artworkUrl100 = artworkUrl100 {
            return artworkUrl100.replacingOccurrences(of: "100x100", with: "1000x1000")
        }else{
            return nil
        }
    }
    var collectionPrice : Double?
    var trackPrice : Double?
    var releaseDate : String?
    var collectionExplicitness : String?
    var trackExplicitness : String?
    var discCount : Int?
    var discNumber : Int?
    var trackCount : Int?
    var trackNumber : Int?
    var trackTimeMillis : Int?
    var country : String?
    var currency : String?
    var primaryGenreName : String?
    var contentAdvisoryRating : String?
    var isStreamable : Bool?
    
    private enum CodingKeys : String ,CodingKey{
        case wrapperType = "wrapperType"
        case kind = "kind"
        case artistID = "artistId"
        case collectionId = "collectionId"
        case trackId = "trackId"
        case artistName = "artistName"
        case collectionName = "collectionName"
        case trackName = "trackName"
        case collectionCensoredName = "collectionCensoredName"
        case trackCensoredName = "trackCensoredName"
        case artistViewUrl = "artistViewUrl"
        case collectionViewUrl = "collectionViewUrl"
        case trackViewUrl = "trackViewUrl"
        case previewUrl = "previewUrl"
        case artworkUrl30 = "artworkUrl30"
        case artworkUrl60 = "artworkUrl60"
        case artworkUrl100 = "artworkUrl100"
        case collectionPrice = "collectionPrice"
        case trackPrice = "trackPrice"
        case releaseDate = "releaseDate"
        case collectionExplicitness = "collectionExplicitness"
        case trackExplicitness = "trackExplicitness"
        case discCount = "discCount"
        case discNumber = "discNumber"
        case trackCount = "trackCount"
        case trackNumber = "trackNumber"
        case trackTimeMillis = "trackTimeMillis"
        case country = "country"
        case currency = "currency"
        case primaryGenreName = "primaryGenreName"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case isStreamable =  "isStreamable"
    }
}

struct SearchSongData : Codable{
    var resultCount : Int
    var results : [SongData]?
    
    private enum CodingKeys : String ,CodingKey{
        case results = "results"
        case resultCount = "resultCount"
    }
}
