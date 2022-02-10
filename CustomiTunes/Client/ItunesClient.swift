//
//  ItunesClient.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 22.01.2022.
//

import Foundation

class ItunesClient{
    
    func searchForName (for searchKey : String ,limit : Int, completion : @escaping(Result<[UnHandleData]? , DownloadError>) -> Void) -> Void{

        let urlSearchKey = searchKey.replacingOccurrences(of: " ", with: "+")
        
        let turkishChar = ["ü" , "ı", "ğ", "ş", "ç" , "ö"]
        let convertChar = ["u" , "i", "g" , "s", "c" , "o"]
        
        var clearSinger = urlSearchKey.lowercased()
        for i in 0..<turkishChar.count{
            clearSinger = clearSinger.replacingOccurrences(of: turkishChar[i], with: convertChar[i])
        }
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(clearSinger)&limit=\(limit)&entity=song&sort=recent&country=TR")else{
            return completion(.failure(.wrongUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, errors in
            guard let data = data else {
                return completion(.failure(.unload))
            }
            guard let finalResult = try? JSONDecoder().decode(SearchData.self,from:data) else{
                return completion(.failure(.unbuild))
            }
            completion(.success(finalResult.results))
        }.resume()

    }
    
    
    func searchForSingerID (for singerID : Double ,limit : Int, completion : @escaping(Result<[UnHandleData]? , DownloadError>) -> Void) -> Void{
        
        let urlSearchKey = Int(singerID)
        
        guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(urlSearchKey)&entity=song&limit=\(limit)&sort=recent&country=TR")else{
            return completion(.failure(.wrongUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, errors in
            guard let data = data else {
                return completion(.failure(.unload))
            }
            guard let finalResult = try? JSONDecoder().decode(SearchData.self,from:data) else{
                return completion(.failure(.unbuild))
            }
            completion(.success(finalResult.results))
        }.resume()
        
    }
    
    func detailForID (for songID : Double, completion : @escaping(Result<UnHandleData? , DownloadError>) -> Void) -> Void{
        guard let url = URL(string:"https://itunes.apple.com/lookup?id=\(Int(songID))&entity=song&country=TR")else{
            return completion(.failure(.wrongUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, errors in
            guard let data = data else {
                return completion(.failure(.unload))
            }
            guard let finalResult = try? JSONDecoder().decode(SearchData.self,from:data) else{
                return completion(.failure(.unbuild))
            }
            completion(.success(finalResult.results![0]))
        }.resume()
    }
    
    func artistAlbumsForArtistID (for artistID : Double, completion : @escaping(Result<[UnHandleData]? , DownloadError>) -> Void) -> Void{
    
   
        guard let url = URL(string:"https://itunes.apple.com/lookup?id=\(Int(artistID))&entity=album&sort=recent")else{
            return completion(.failure(.wrongUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, errors in
            guard let data = data else {
                return completion(.failure(.unload))
            }
            
            guard let finalResult = try? JSONDecoder().decode(SearchData.self,from:data) else{
                return completion(.failure(.unbuild))
            }
            completion(.success(finalResult.results))
        }.resume()
    }
    
}

enum DownloadError : Error {
    case wrongUrl
    case unload
    case unbuild
}
