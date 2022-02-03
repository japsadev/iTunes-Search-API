//
//  MusicClient.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 1.02.2022.
//

import Foundation

class MusicClient : ObservableObject{
    
    @Published var downloadedMusic : Data?
    func downloadSound(url: String){
        guard let soundURL = URL(string: url)else{
            return
        }
        URLSession.shared.dataTask(with: soundURL) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.downloadedMusic = data
            }
        }.resume()
    }
}
