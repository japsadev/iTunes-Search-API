//
//  PopularView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 25.01.2022.
//

import SwiftUI

struct PopularView: View {
    @StateObject private var viewModel: PopularViewModel = PopularViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    BigCardsScrollView(scroolKey: "LOCAL_FIRST_SCROOL_KEY")
                    TrackSectionView(title: "LOCAL_COUNTRY_RISERS", contentKey: "LOCAL_COUNTRY_LIST_KEY")
                    TrackSectionView(title: "LOCAL_GLOBAL_HITS", contentKey: "LOCAL_GLOBAL_LIST_KEY")
                    BigCardsScrollView(scroolKey: "LOCAL_SECOND_SCROOL_KEY")
                }
            }.navigationTitle("LOCAL_POPULAR_CONTENT")
                .environmentObject(viewModel)
        }
    }
}

struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        PopularView()
    }
}
