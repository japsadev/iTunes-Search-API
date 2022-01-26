//
//  LitteSongView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 26.01.2022.
//

import SwiftUI

struct LitteSongView: View {
    var song : PopularViewModel
    
    var body: some View {
        VStack(alignment:.leading,spacing:4){
            AsyncImage(url: self.song.songImage) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80, alignment: .center)
                    .cornerRadius(5)
                    .shadow(radius: 5, x: 0, y: 0)
            } placeholder: {
                ProgressView()
            }
            Text(self.song.songName)
                .frame(width: 80 , height: 60, alignment: .center)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
    }
}
