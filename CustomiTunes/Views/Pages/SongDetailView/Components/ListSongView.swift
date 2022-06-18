//
//  ListSongView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 2.02.2022.
//

import SwiftUI

struct ListSongView: View { // TODO: Replace this async image
    private let contentSize: CGFloat = 15.0.responsiveW
    var songData: SongData
    
    var body: some View {
        NavigationLink {
            SongDetailView(songId: songData.wrappedId)
        } label: {
            VStack(alignment:.leading,spacing:5){
                HStack{
                    AnimatedAsyncImageView(imageURL: songData.smallImageURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: contentSize, height: contentSize, alignment: .center)
                            .clipped()
                            .cornerRadius(10)
                    } errorView: {
                        
                    } placeHolderView: {
                        ProgressView()
                            .background(
                                Rectangle()
                                    .frame(width: contentSize, height: contentSize)
                                    .cornerRadius(10)
                                    .foregroundColor(.secondary.opacity(0.3))
                            )
                    }.frame(width: contentSize, height: contentSize, alignment: .center)
                    
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
