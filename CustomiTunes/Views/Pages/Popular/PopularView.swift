//
//  PopularView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 25.01.2022.
//

import SwiftUI

struct PopularView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                HScrollSpecialView()
                HScroolWithTitleView(title: "Music")
            }.navigationTitle("Popular Content")
                .padding(.bottom,10)
        }
    }
}

struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        PopularView()
    }
}
