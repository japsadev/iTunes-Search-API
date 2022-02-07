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
        NavigationLink {
            SongDetailView(detailSongId: self.song.id)
        } label: {
            VStack(alignment:.leading,spacing:4){
                AsyncImage(url: self.song.songImage) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100, alignment: .center)
                        .cornerRadius(5)
                        .shadow(radius: 5, x: 0, y: 0)
                } placeholder: {
                    ZStack{
                        Rectangle()
                            .frame(width: 100, height: 100, alignment: .center)
                            .foregroundColor(.primary.opacity(0.1))
                            .cornerRadius(5)
                        ProgressView()
                    }
                }
                VStack(alignment:.leading, spacing:4){
                    HStack(alignment:.top){
                        Text(self.song.songName)
                            .foregroundColor(.primary)
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        Spacer()
                        ExplicitView(explicitState: song.trackExplicitness)
                    }
                    Text(self.song.singerName)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                }.frame(width: 95, height: 50, alignment: .topLeading)
            }
        }
    }
}
