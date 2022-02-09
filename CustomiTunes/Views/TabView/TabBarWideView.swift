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
            TabBarButtonView(title: "LOCAL_POPULAR", image: "star", currentTab: self.$selection)
            TabBarButtonView(title: "LOCAL_SEARCH", image: "magnifyingglass", currentTab: self.$selection)
            TabBarButtonView(title: "LOCAL_FAVORITE", image: "heart", currentTab: self.$selection)
//            TabBarButtonView(title: "Music", image: "guitars", currentTab: self.$selection)
        }

    }
}
