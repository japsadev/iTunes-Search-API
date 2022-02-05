//
//  SearchView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 31.01.2022.
//

import SwiftUI

struct SearchView: View {
    @State private var searchKey = ""
    @ObservedObject private var pageClient = SearchViewClient()
    var body: some View {
        NavigationView{
            ScrollView{
                SearchBarView(searchKey: self.$searchKey)
                if !self.pageClient.searchResult.isEmpty{
                    ForEach(self.pageClient.searchResult){ song in
                        SearchListItemView(listSong: song)
                    }
                }
            }.navigationTitle("Search")
                .padding(.bottom,10)
        }.onSubmit {
            Task{
                self.pageClient.searchResult.removeAll()
            }
            self.pageClient.getSearchResult(for: self.searchKey)
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
