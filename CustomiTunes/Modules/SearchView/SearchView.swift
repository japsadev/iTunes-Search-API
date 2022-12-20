//
//  SearchView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 20.06.2022.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var viewModel: SearchViewModel = SearchViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.searchResult, id: \.self.wrappedId) { track in
                    ListSongView(songData: track, fieldSize: 80.0.responsiveW)
                }.listRowSeparator(.hidden)
            }.navigationTitle("Search")
                .searchable(text: $viewModel.searchKey, prompt: "Search an Song or Artist", suggestions: {
                    ForEach(AppConstants.shared.recommendedList, id: \.self) { suggestion in
                        Button(LocalizedStringKey(suggestion)) {
                            viewModel.searchKey = NSLocalizedString(suggestion, comment: "for good search")
                        }
                    }.listRowSeparator(.hidden)
                })
                .listStyle(.plain)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
