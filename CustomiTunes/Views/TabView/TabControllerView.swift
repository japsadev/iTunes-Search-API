//
//  TabControllerView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 22.01.2022.
//

import SwiftUI

struct TabControllerView: View {
    @ObservedObject private var favoriteService = FavoriteService()
    @State private var selection = "LOCAL_POPULAR"
    var body: some View {
        TabView(selection: self.$selection) {
            PopularView()
                .tag("LOCAL_POPULAR")
            SearchView()
                .tag("LOCAL_SEARCH")
            FavoriteView()
                .tag("LOCAL_FAVORITE")
        }.overlay(
            TabBarWideView(selection: self.$selection)
                .padding(.top, 5)
                .background(.ultraThinMaterial),
            alignment: .bottom
        ).environmentObject(favoriteService)
    }
}

struct TabControllerView_Previews: PreviewProvider {
    static var previews: some View {
        TabControllerView()
    }
}
