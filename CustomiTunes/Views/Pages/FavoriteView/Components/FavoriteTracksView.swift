//
//  FavoriteTracksView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 18.06.2022.
//

import SwiftUI

struct FavoriteTracksView: View {
    @EnvironmentObject private var favoriteService: FavoriteService
    private let contentSize = 20.0.responsiveW
    var trackData: SongData

    var body: some View {
        HStack {
            Button {
                favoriteService.addOrRemoveFavorite(trackData.wrappedId)
            } label: {
                Image(systemName: "heart.fill")
            }

            AnimatedAsyncImageView(imageURL: trackData.middleImageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: contentSize, height: contentSize, alignment: .center)
                    .clipped()
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.3))
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
            VStack(alignment: .leading, spacing: 5) {
                Text(trackData.wrappedTrackName)
                    .font(.headline)
                    .lineLimit(1)

                NavigationLink {
                    ArtistDetailView(artistID: trackData.artistId)
                } label: {
                    Text(trackData.wrappedArtistName)
                        .font(.footnote)
                }
                Spacer()
            }.padding(.top, 2)
            Spacer()
        }.padding(.horizontal)
            .padding(.bottom, 5)
    }
}

struct FavoriteTracksView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
