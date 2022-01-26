//
//  TabBarWideView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 22.01.2022.
//

import SwiftUI

struct TabBarWideView: View {
    @Binding var selection : String
    var body: some View {
        HStack(spacing:0){
            TabBarButtonView(title: "Popular", image: "star", currentTab: self.$selection)
//            TabBarButtonView(title: "Search", image: "magnifyingglass", currentTab: self.$selection)
//            TabBarButtonView(title: "Movie", image: "film", currentTab: self.$selection)
//            TabBarButtonView(title: "Music", image: "guitars", currentTab: self.$selection)
        }

    }
}
