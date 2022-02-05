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
    let recommendedList  = [
        "ece seçkin",
        "zeynep bastık",
        "reynmen",
        "ezhel",
        "sefo",
        "edis",
        "yüzyüzeyken konuşuruz",
    ]
    var body: some View {
        NavigationView{
            ScrollView{
                SearchBarView(searchKey: self.$searchKey,pageClient: self.pageClient)
                if self.pageClient.searchResult.isEmpty{
                    ForEach(self.recommendedList, id: \.self){ recommed in
                        Button {
                            self.searchKey = recommed
                            Task{
                                self.pageClient.searchResult.removeAll()
                            }
                            self.pageClient.getSearchResult(for: self.searchKey)
                        } label: {
                            Text(recommed)
                        }
                    }
                }
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
