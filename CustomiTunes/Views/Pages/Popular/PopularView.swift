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
                HScrollSpecialView(scroolKey: "LOCAL_FIRST_SCROOL_KEY")
                HScroolWithTitleView(title: "LOCAL_COUNTRY_RISERS",contentKey: "LOCAL_COUNTRY_LIST_KEY")
                HScroolWithTitleView(title: "LOCAL_GLOBAL_HITS",contentKey: "LOCAL_GLOBAL_LIST_KEY")
                HScrollSpecialView(scroolKey: "LOCAL_SECOND_SCROOL_KEY")
            }.navigationTitle("LOCAL_POPULAR_CONTENT")
                .padding(.bottom,10)
        }
    }
}

struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        PopularView()
    }
}
