//
//  SearchListItemView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 5.02.2022.
//

import SwiftUI

struct SearchListItemView: View {
    var listSong : SearchViewModel
    var body: some View {
        NavigationLink {
            SongDetailView(songId: listSong.id)
        } label: {
            VStack(alignment:.leading,spacing:5){
                Divider()
                HStack{
                    AsyncImage(url:listSong.songImage) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 10)
                    }.frame(width: 15.0.responsiveW, height: 15.0.responsiveW, alignment: .center)
                    VStack(alignment:.leading){
                        HStack{
                            Text(listSong.songName)
                                .font(.title3)
                            ExplicitView(explicitState: listSong.trackExplicitness)
                        }
                        Text(listSong.artistName)
                            .font(.callout)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                }
            }.frame(width: 90.0.responsiveW, height: 15.0.responsiveW, alignment: .center)
                .foregroundColor(.primary)
        }
    }
}

