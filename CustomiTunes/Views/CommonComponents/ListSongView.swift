//
//  ListSongView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 2.02.2022.
//

import SwiftUI

struct ListSongView: View {
    private let contentSize: CGFloat = 15.0.responsiveW
    var songData: SongData
    var fieldSize: CGFloat? = 90.0.responsiveW

    var body: some View {
        NavigationLink {
            SongDetailView(songId: songData.wrappedId)
        } label: {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    AnimatedAsyncImageView(imageURL: songData.smallImageURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: contentSize, height: contentSize, alignment: .center)
                            .clipped()
                            .cornerRadius(10)
                    } errorView: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFill()
                            .frame(width: contentSize, height: contentSize, alignment: .center)
                            .clipped()
                            .cornerRadius(10)
                            .background(
                                Rectangle()
                                    .frame(width: contentSize, height: contentSize)
                                    .cornerRadius(10)
                                    .foregroundColor(.secondary.opacity(0.3))
                            )
                    } placeHolderView: {
                        ProgressView()
                            .background(
                                Rectangle()
                                    .frame(width: contentSize, height: contentSize)
                                    .cornerRadius(10)
                                    .foregroundColor(.secondary.opacity(0.3))
                            )
                    }.frame(width: contentSize, height: contentSize, alignment: .center)
                    VStack(alignment: .leading) {
                        HStack {
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
            }.frame(width: self.fieldSize, height: contentSize, alignment: .center)
                .foregroundColor(.primary)
        }
    }
}
