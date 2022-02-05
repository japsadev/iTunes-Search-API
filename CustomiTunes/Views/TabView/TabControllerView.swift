//
//  TabControllerView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 22.01.2022.
//

import SwiftUI

struct TabControllerView: View {
    @State private var selection = "Popular"
    var body: some View {
        TabView(selection: self.$selection){
            PopularView()
                .tag("Popular")
            SearchView()
                .tag("Search")
//            ContentView()
//                .tag("Movie")
//            ContentView()
//                .tag("Music")
        }.overlay(
            TabBarWideView(selection: self.$selection)
                .padding(.vertical,5)
                .background(.ultraThinMaterial)
            ,alignment: .bottom
        )
    }
}

struct TabControllerView_Previews: PreviewProvider {
    static var previews: some View {
        TabControllerView()
    }
}
