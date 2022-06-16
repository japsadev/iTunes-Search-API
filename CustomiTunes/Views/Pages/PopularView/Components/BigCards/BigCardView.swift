//
//  BigCardView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 29.01.2022.
//

import SwiftUI

struct BigCardView: View {
    private let imageWidth: CGFloat = 85.0.responsiveW
    private let imageHeight: CGFloat = 50.0.responsiveW
    
    let contentURL : URL
    let contentKey : String
    let branchPageTitle : String
    
    var body: some View {
        NavigationLink {
            SongsExpandedView(contentKey: self.contentKey, pageTitle: self.branchPageTitle)
        } label: {
            AnimatedAsyncImageView(imageURL: contentURL) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: imageWidth, height: imageHeight, alignment: .center)
                    .cornerRadius(10)
                    .clipped()
                    .shadow(radius: 2, x: 4, y: 4)
            } errorView: {
                Image(systemName: "xmark.circle")
                    .background(
                        Rectangle().frame(width: imageWidth, height: imageHeight)
                            .foregroundColor(.clear)
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                    )
            } placeHolderView: {
                ProgressView()
                    .background(
                        Rectangle().frame(width: imageWidth, height: imageHeight)
                            .foregroundColor(.clear)
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                    )
            }
        }.frame(width: imageWidth, height: imageHeight)
    }
}

struct BigCardView_Previews: PreviewProvider {
    static var previews: some View {
        BigCardView(contentURL: URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Features114/v4/01/e7/76/01e7760b-03e9-46c0-7579-0614e51db340/source/1000x611sr-60.jpg")!, contentKey: "turkeySongs", branchPageTitle: "")
    }
}
