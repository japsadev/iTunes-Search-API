//
//  iTunesServices.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 9.06.2022.
//

import Foundation

struct ItunesServices{
    let serviceURL = "https://itunes.apple.com"
    
    // MARK: Helper methods
    func createRequestUrl(endpoint: String, query: String?) -> URL?{
        return URL(string: self.serviceURL + endpoint + (query ?? ""))
    }
    
    func handleProperties(_ key: String) -> String{
        var resultKey = key.replacingOccurrences(of: " ", with: "+").lowercased()
        
        let turkishChar = ["ü" , "ı", "ğ", "ş", "ç" , "ö"]
        let convertChar = ["u" , "i", "g" , "s", "c" , "o"]
        
        for i in 0..<turkishChar.count{
            resultKey = resultKey.replacingOccurrences(of: turkishChar[i], with: convertChar[i])
        }
        
        return resultKey
    }
    
    // MARK: Request methods
    func searchByNameOrId(_ nameOrId: String, limit: Int? = 10, isAblum: Bool? = false, completion: @escaping(Result<Any?, DownloadError>) -> Void){
        let id: Double? = Double(nameOrId)
        var requestURL: URL?
        
        if let id = id {
            let query: String = isAblum! ? "?id=\(id)&entity=album&limit=\(limit!)&sort=recent&country=TR" : "?id=\(id)&entity=song&limit=\(limit!)&sort=recent&country=TR"
            guard let handledURL = createRequestUrl(endpoint: "/lookup", query: query) else { return completion(.failure(.wrongUrl))}
            requestURL = handledURL
        }else{
            let handledName = handleProperties(nameOrId)
            guard let handledURL = createRequestUrl(endpoint: "/search", query: "?term=\(handledName)&limit=\(limit!)&entity=song&sort=recent&country=TR") else { return completion(.failure(.wrongUrl))}
            requestURL = handledURL
        }
        
        URLSession.shared.dataTask(with: requestURL!) { responseData, response, error in
            guard let responseData = responseData else { return completion(.failure(.unload)) }
            if isAblum!{
                guard let handledData = try? JSONDecoder().decode(SearchAlbumData.self, from: responseData) else { return completion(.failure(.unbuild))}
                return completion(.success(handledData.results))
            }else{
                guard let handledData = try? JSONDecoder().decode(SearchSongData.self, from: responseData) else { return completion(.failure(.unbuild))}
                return completion(.success(handledData.results))
            }
        }.resume()
    }
}
