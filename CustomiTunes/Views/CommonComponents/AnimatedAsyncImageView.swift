//
//  AnimatedAsyncImageView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 12.06.2022.
//

import SwiftUI

struct AnimatedAsyncImageView<Content: View, ErrorContent: View, PlaceHolderContent: View>: View {
    var imageView: (_ image: Image) -> Content
    var errorView: ErrorContent
    var placeHolderView: PlaceHolderContent
    var imageURL: URL

    init(
        imageURL: URL,
        @ViewBuilder imageView: @escaping (_ image: Image) -> Content,
        @ViewBuilder errorView: @escaping () -> ErrorContent,
        @ViewBuilder placeHolderView: @escaping () -> PlaceHolderContent
    ) {
        self.imageView = imageView
        self.imageURL = imageURL
        self.errorView = errorView()
        self.placeHolderView = placeHolderView()
    }

    var body: some View {
        AsyncImage(url: imageURL, scale: 1, transaction: .init(animation: .easeInOut)) { phase in
            if let loadedImage = phase.image {
                imageView(loadedImage)
            } else if phase.error != nil {
                errorView
            } else {
                placeHolderView
            }
        }
    }
}

struct AnimatedAsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        // swiftlint: disable line_length
        let imageURL = URL(string: "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=250&q=80")!
        // swiftlint: enable line_length
        AnimatedAsyncImageView(imageURL: imageURL) { image in
            image.resizable()
                .scaledToFill()
                .frame(width: 15.0.responsiveH, height: 15.0.responsiveH, alignment: .center)
                .clipped()
                .cornerRadius(10)
        } errorView: {
            Image(systemName: "xmark")
                .padding(14.0.responsiveW)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
        } placeHolderView: {
            ProgressView()
                .padding(14.0.responsiveW)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .tint(.accentColor)
        }
    }
}
