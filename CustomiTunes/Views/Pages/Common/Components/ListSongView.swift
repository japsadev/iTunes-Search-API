//
//  ListSongView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 2.02.2022.
//

import SwiftUI

@available(*, deprecated, message: "It will be soon moved to a new page" )
struct ListSongView: View {
    var listSong : DetailListViewModel
    var body: some View {
        NavigationLink {
            SongDetailView(detailSongId: listSong.id)
        } label: {
            VStack(alignment:.leading,spacing:5){
                Divider()
                HStack{
                    AsyncImage(url:listSong.trackImage) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 10)
                    }.frame(width: 15.0.responsiveW, height: 15.0.responsiveW, alignment: .center)
                    VStack(alignment:.leading){
                        HStack{
                            Text(listSong.trackName)
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
