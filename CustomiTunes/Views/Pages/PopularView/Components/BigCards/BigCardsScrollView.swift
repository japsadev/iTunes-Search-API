//
//  BigCardsScrollView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 29.01.2022.
//

import SwiftUI

struct BigCardsScrollView: View {
    @EnvironmentObject private var viewModel: PopularViewModel2
    var scroolKey : String
    
    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing:0){
                if let cards = viewModel.getCards(scroolKey){
                    ForEach(cards, id: \.contentKey) { card in
                        BigCardView(contentURL: card.cardURL,contentKey: card.contentKey, branchPageTitle: card.pageTitle)
                            .padding([.leading, .bottom, .top])
                    }
                    Rectangle()
                        .frame(width: 0, height: 0)
                        .padding(.trailing)
                }
            }
        }
    }
}

struct BigCardsScrollView_Previews: PreviewProvider {
    static var previews: some View {
        BigCardsScrollView(scroolKey: "LOCAL_FIRST_SCROOL_KEY")
    }
}
