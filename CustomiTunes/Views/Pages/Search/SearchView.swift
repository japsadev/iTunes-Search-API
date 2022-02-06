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
        "LOCAL_SEARCHTIPS_1",
        "LOCAL_SEARCHTIPS_2",
        "LOCAL_SEARCHTIPS_3",
        "LOCAL_SEARCHTIPS_4",
        "LOCAL_SEARCHTIPS_5",
        "LOCAL_SEARCHTIPS_6",
        "LOCAL_SEARCHTIPS_7",
        "LOCAL_SEARCHTIPS_8",
    ]
    var body: some View {
        NavigationView{
            ScrollView{
                SearchBarView(searchKey: self.$searchKey,pageClient: self.pageClient)
                if self.pageClient.searchResult.isEmpty{
                    ForEach(self.recommendedList, id: \.self){ recommed in
                        Button {
                            self.searchKey = NSLocalizedString(recommed, comment: "searchKeys")
                            Task{
                                self.pageClient.searchResult.removeAll()
                            }
                            self.pageClient.getSearchResult(for: self.searchKey)
                        } label: {
                            Text(LocalizedStringKey(recommed))
                                .foregroundColor(Color("ThemeColor"))
                        }
                    }
                }
                if !self.pageClient.searchResult.isEmpty{
                    ForEach(self.pageClient.searchResult){ song in
                        SearchListItemView(listSong: song)
                    }
                }
            }.navigationTitle("LOCAL_SEARCH")
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
