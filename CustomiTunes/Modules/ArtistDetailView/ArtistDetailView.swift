//
//  ArtistDetailView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 20.06.2022.
//

import SwiftUI

struct ArtistDetailView: View {
    @Environment(\.openURL) private var openURL
    private let contentSize: CGFloat = 90.0.responsiveW
    @ObservedObject private var viewModel: ArtistDetailViewModel = ArtistDetailViewModel()
    var artistID: Double

    var body: some View {
        if viewModel.pageState == .loading {
            VStack {
                ProgressView()
            }.onAppear {
                viewModel.getDatas(artistID)
            }
        } else if viewModel.pageState == .successful {
            let artistData = viewModel.artistData!
            ScrollView {
                AnimatedAsyncImageView(imageURL: artistData.image) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: contentSize, height: contentSize, alignment: .center)
                        .clipped()
                        .cornerRadius(10)
                } errorView: {
                    Image(systemName: "xmark")
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
                }.frame(width: contentSize, height: contentSize)

                ActionButtonView(activeIcon: "safari", activeTitle: "LOCAL_ARTIST_WEB_VIEW", buttonWidth: 90.0.responsiveW) {
                    openURL.callAsFunction(viewModel.artistSongs.last!.wrappedArtistViewURL)
                }

                if viewModel.artistSongs.isEmpty {
                    ProgressView()
                } else {
                    ForEach(viewModel.artistSongs, id: \.self.wrappedId) { track in
                        ListSongView(songData: track)
                    }
                }
            }.navigationTitle(viewModel.setPageTitle(artistData.name))
                .navigationBarTitleDisplayMode(.inline)
        } else {
            Text("Bilinmiyor")
        }
    }
}

struct ArtistDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistDetailView(artistID: 1446365464.0)
    }
}
