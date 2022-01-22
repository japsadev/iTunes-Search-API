//
//  TabView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 22.01.2022.
//

import SwiftUI

struct TabView: View {
    @State private var selection = "Popular"
    var body: some View {
        TabView(selection:self.$selection){
            ContentView()
                .tag("Popular")
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}
