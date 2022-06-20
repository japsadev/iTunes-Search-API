//
//  FavoriteView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 18.06.2022.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject private var favoriteService: FavoriteService
    @ObservedObject private var viewModel: FavoriteViewModel =  FavoriteViewModel()
    
    var body: some View {
        NavigationView{
            Group{
                if viewModel.pageState == .loading{
                    VStack{
                        ProgressView()
                    }
                }else{
                    ScrollView{
                        ForEach(viewModel.favoriteTracks, id: \.self.wrappedId){ track in
                            NavigationLink{
                                SongDetailView(songId: track.wrappedId)
                            } label: {
                                FavoriteTracksView(trackData: track)
                            }.buttonStyle(.plain)
                                .listRowSeparator(.hidden)
                        }
                    }.listStyle(.plain)
                }
            }.navigationTitle(LocalizedStringKey("LOCAL_FAVORITE_TITLE"))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.accountSheet.toggle()
                        } label: {
                            Image(systemName: "person.circle")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
        }.onAppear{
            viewModel.getFavoriteTracks(tracks: favoriteService.favoriteTrackIds)
        }.sheet(isPresented: $viewModel.accountSheet) {
            AccountView()
        }.onChange(of: favoriteService.favoriteTrackIds) { newFavoriteList in
            viewModel.getFavoriteTracks(tracks: newFavoriteList)
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
