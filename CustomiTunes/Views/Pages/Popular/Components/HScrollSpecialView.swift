//
//  HScrollSpecialView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 29.01.2022.
//

import SwiftUI

struct HScrollSpecialView: View {
    @ObservedObject private var pageClient = PopularSongClient()
    var body: some View {
        if self.pageClient.popularContentUrls.isEmpty{
            ProgressView()
        }else{
            ScrollView(.horizontal){
                HStack(spacing:13){
                    ForEach(self.pageClient.popularContentUrls, id: \.self) { contentUrl in
                        SpecialContentView(contentURL: contentUrl)
                    }
                }.padding(.bottom)
            }.padding(.leading)
        }
    }
}

struct HScrollSpecialView_Previews: PreviewProvider {
    static var previews: some View {
        HScrollSpecialView()
    }
}
