//
//  iTunesServices.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 9.06.2022.
//

import Foundation

struct ItunesServices {
    private let serviceURL = "https://itunes.apple.com"

    // MARK: Helper methods
    private func createRequestUrl(endpoint: String, query: String?) -> URL? {
        return URL(string: self.serviceURL + endpoint + (query ?? "") + "&sort=recent" + "&country=TR")
    }

    private func handleProperties(_ key: String) -> String {
        var resultKey = key.replacingOccurrences(of: " ", with: "+").lowercased()

        let turkishChar = ["ü", "ı", "ğ", "ş", "ç", "ö"]
        let convertChar = ["u", "i", "g", "s", "c", "o"]

        for char in 0..<turkishChar.count {
            resultKey = resultKey.replacingOccurrences(of: turkishChar[char], with: convertChar[char])
        }

        return resultKey
    }

    // MARK: Request method
    func searchByNameOrId(
        _ nameOrId: String,
        limit: Int = 10,
        isAblum: Bool = false,
        completion: @escaping(Result<Any?, DownloadError>) -> Void
    ) {
        let id: Double? = Double(nameOrId)
        var requestURL: URL?

        if let id = id {
            let formattedId = Int(id)
            let query: String = "?id=\(formattedId)&entity=\(isAblum ? "album" : "song")&limit=\(limit)"
            guard let handledURL = createRequestUrl(endpoint: "/lookup", query: query) else {
                return completion(.failure(.wrongUrl(url: requestURL?.query ?? "")))
            }
            requestURL = handledURL
        } else {
            let handledName = handleProperties(nameOrId)
            let query = "?term=\(handledName)&limit=\(limit)&entity=song"
            guard let handledURL = createRequestUrl(endpoint: "/search", query: query) else {
                return completion(.failure(.wrongUrl(url: requestURL?.query ?? "")))
            }
            requestURL = handledURL
        }

        guard let requestURL else { return }
        URLSession.shared.dataTask(with: requestURL) { responseData, _, _ in
            guard let responseData else { return completion(.failure(.unload(url: requestURL.query ?? ""))) }

            // TODO: Use T type
            if isAblum {
                guard let handledData = try? JSONDecoder().decode(SearchAlbumData.self, from: responseData) else {
                    return completion(.failure(.unbuild(url: requestURL.query ?? "")))
                }
                return completion(.success(handledData.results))
            } else {
                guard let handledData = try? JSONDecoder().decode(SearchSongData.self, from: responseData) else {
                    return completion(.failure(.unbuild(url: requestURL.query ?? "")))
                }
                return completion(.success(handledData.results))
            }
        }.resume()
    }
}
