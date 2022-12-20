//
//  MusicPlayerView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 2.02.2022.
//

import SwiftUI

struct MusicPlayerView: View {
    @EnvironmentObject private var favoriteService: FavoriteService
    @Environment(\.openURL) var openURL
    @ObservedObject private var viewModel: MusicPlayerViewModel = MusicPlayerViewModel()
    var songData: SongData

    var body: some View {
        VStack {
            AnimatedAsyncImageView(imageURL: songData.bigImageURL) { image in
                VStack {
                    image.resizable()
                        .scaledToFill()
                        .frame(width: viewModel.imageContentSize, height: viewModel.imageContentSize, alignment: .center)
                        .clipShape(Circle())
                        .rotationEffect(Angle(degrees: viewModel.rotationEffectRadius))
                        .overlay(ClearCircle())
                    HStack {
                        ActionButtonView(
                            isValue: $viewModel.favoriteState,
                            activeIcon: "heart.fill",
                            disActiveIcon: "heart",
                            activeTitle: "Remove",
                            disActiveTitle: "Add"
                        ) {
                            favoriteService.addOrRemoveFavorite(songData.wrappedId)
                            viewModel.favoriteButtonAction()
                        }.onAppear {
                            viewModel.setFavoriteButtonState(state: favoriteService.isFavorite(songData.wrappedId))
                        }
                        ActionButtonView(
                            isValue: $viewModel.playingState,
                            activeIcon: "stop.fill",
                            disActiveIcon: "play",
                            activeTitle: "Stop",
                            disActiveTitle: "Play"
                        ) {
                            viewModel.playButtonAction(songPreview: songData.wrappedTrackPreview)
                        }
                        ActionButtonView(isValue: $viewModel.webState, activeIcon: "safari", activeTitle: "Web") {
                            openURL.callAsFunction(songData.wrappedTrackViewURL)
                        }
                    }.padding(.top)
                }
            } errorView: {
                Image(systemName: "xmark")
                    .padding()
                    .frame(width: viewModel.imagePlaceholderSize, height: viewModel.imagePlaceholderSize, alignment: .center)
                    .background(.ultraThickMaterial)
                    .cornerRadius(500)
                    .tint(.accentColor)
            } placeHolderView: {
                ProgressView()
                    .padding()
                    .frame(width: viewModel.imagePlaceholderSize, height: viewModel.imagePlaceholderSize, alignment: .center)
                    .background(.ultraThickMaterial)
                    .cornerRadius(500)
                    .tint(.accentColor)
            }.frame(width: 100.0.responsiveW, height: 74.0.responsiveW + 8.0.responsiveH, alignment: .top)
        }.onDisappear {
            viewModel.rotationEffectRadius = 0
            viewModel.player.pause()
            viewModel.player.removeAllItems()
        }
    }
}

struct MusicPlayerViewPreview: PreviewProvider {
    static var previews: some View {
        SongDetailView(songId: 1621475284.0)
    }
}

struct ClearCircle: View {
    @Environment(\.colorScheme) private var colorScheme
    var radius: CGFloat? = 6.0.responsiveW

    var body: some View {
        Circle()
            .foregroundColor(colorScheme == .dark ? .black : .white)
            .frame(width: radius, height: radius, alignment: .center)
    }
}
