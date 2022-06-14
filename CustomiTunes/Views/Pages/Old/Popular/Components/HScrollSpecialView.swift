//
//  HScrollSpecialView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 29.01.2022.
//

import SwiftUI

struct HScrollSpecialView: View {
    var scroolKey : String
    @ObservedObject private var pageClient = PopularSongClient(contentKey: nil)
    var body: some View {
        if self.pageClient.popularContentUrls.isEmpty{
            ProgressView()
        }else{
            ScrollView(.horizontal){
                HStack(spacing:13){
                    if let cards = self.pageClient.popularContentUrls[self.pageClient.hScroolKeyConventer(for: scroolKey)]{
                        ForEach(cards) { card in
                            SpecialContentView(contentURL: card.cardURL,contentKey: card.contentKey,branchPageTitle: card.pageTitle)
                        }
                    }
                    
                }.padding(.bottom)
            }.padding(.leading)
        }
    }
}

struct HScrollSpecialView_Previews: PreviewProvider {
    static var previews: some View {
        HScrollSpecialView(scroolKey: "scrool1")
    }
}
