//
//  SmallTrackView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 15.06.2022.
//

import SwiftUI

struct SmallTrackView: View {
    let contentSize: CGFloat = 25.0.responsiveW
    var completedViewSize: CGFloat{
        contentSize + 15.0.responsiveW
    }
    
    let trackData: SongData
    
    
    var body: some View {
        VStack(alignment: .leading){
            AnimatedAsyncImageView(imageURL: trackData.middleImageURL) { image in
                ZStack(alignment: .bottomTrailing){
                    image.resizable()
                        .scaledToFill()
                        .frame(width: contentSize, height: contentSize)
                        .clipped()
                        .cornerRadius(5)
                    ExplicitView(explicitState: trackData.wrappedTrackExplicitness)
                        .padding(8)
                }
            } errorView: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFill()
                frame(width: contentSize, height: contentSize)
                    .clipped()
                    .cornerRadius(10)
            } placeHolderView: {
                ProgressView()
                    .background(
                        Rectangle()
                            .frame(width: contentSize, height: contentSize)
                            .cornerRadius(10)
                            .foregroundColor(.secondary.opacity(0.3))
                    )
            }.frame(width: contentSize, height: contentSize)
            
            VStack(alignment: .leading, spacing: 3){
                Text(trackData.wrappedTrackName)
                    .font(.caption2)
                    .lineLimit(2)
                
                NavigationLink {
                    // ArtistView
                } label: {
                    Text(trackData.wrappedArtistName)
                        .font(.caption2)
                        .lineLimit(1)
                }
            }
        }.frame(width: contentSize, height: completedViewSize, alignment: .top)
    }
}
