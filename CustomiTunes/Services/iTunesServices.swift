//
//  iTunesServices.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 9.06.2022.
//

import Foundation

struct ItunesServices<T: Codable> {
    private let serviceURL = "https://itunes.apple.com"

    func searchWithKey(
        _ searchKey: String,
        isAlbum: Bool = false,
        limit: Int = 10,
        completion: @escaping(Result<T, DownloadError>) -> Void
    ) {
        guard let requestURL = handleUrlParematerForRequest(searchKey, isAlbum: isAlbum, limit: limit) else { return }
        URLSession.shared.dataTask(with: requestURL) { responseData, _, _ in
            guard let responseData else { return completion(.failure(.unload(url: requestURL.query ?? ""))) }
            guard let handledData = try? JSONDecoder().decode(T.self, from: responseData) else {
                return completion(.failure(.unbuild(url: requestURL.query ?? "")))
            }
            return completion(.success(handledData))
        }.resume()
    }
}

// MARK: - Helper method(s)
extension ItunesServices {
    private func handleUrlParematerForRequest(_ searchKey: String, isAlbum: Bool, limit: Int) -> URL? {
        if let id = Double(searchKey) {
            let formattedId = Int(id)
            let query: String = "?id=\(formattedId)&entity=\(isAlbum ? "album" : "song")&limit=\(limit)"
            guard let handledURL = createRequestUrl(endpoint: "/lookup", query: query) else { return nil }
            return handledURL
        }

        let handledName = handleProperties(searchKey)
        let query = "?term=\(handledName)&limit=\(limit)&entity=song"
        guard let handledURL = createRequestUrl(endpoint: "/search", query: query) else { return nil }
        return handledURL
    }

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
}
