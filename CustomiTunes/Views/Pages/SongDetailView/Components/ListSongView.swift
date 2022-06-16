//
//  ListSongView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 2.02.2022.
//

import SwiftUI

struct ListSongView: View { // TODO: Replace this async image
    var songData : SongData
    
    var body: some View {
        NavigationLink {
            SongDetailView(songId: songData.wrappedId)
        } label: {
            VStack(alignment:.leading,spacing:5){
                HStack{
                    AsyncImage(url: songData.smallImageURL) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 10)
                    }.frame(width: 15.0.responsiveW, height: 15.0.responsiveW, alignment: .center)
                    VStack(alignment:.leading){
                        HStack{
                            Text(songData.wrappedTrackName)
                                .font(.title3)
                            ExplicitView(explicitState: songData.wrappedTrackExplicitness)
                        }
                        Text(songData.wrappedArtistName)
                            .font(.callout)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                }
                Divider()
            }.frame(width: 90.0.responsiveW, height: 15.0.responsiveW, alignment: .center)
                .foregroundColor(.primary)
        }
    }
}
