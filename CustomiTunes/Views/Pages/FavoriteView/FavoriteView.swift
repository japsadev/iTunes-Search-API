//
//  FavoriteView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 18.06.2022.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject private var viewModel: FavoriteViewModel =  FavoriteViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(viewModel.favoriteTracks, id: \.self.wrappedId){ track in
                    NavigationLink{
                        SongDetailView(songId: track.wrappedId)
                    } label: {
                        FavoriteTracksView(trackData: track)
                    }.buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                }
            }.navigationTitle(LocalizedStringKey("LOCAL_FAVORITE_TITLE"))
                .listStyle(.plain)
                
                
                
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
