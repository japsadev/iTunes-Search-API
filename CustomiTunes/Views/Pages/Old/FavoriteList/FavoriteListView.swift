//
//  FavoriteListView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 9.02.2022.
//

import SwiftUI

struct FavoriteListView: View {
    @ObservedObject private var pageClient = FavoriteListClient()
    @State private var isHide = false
    
    var body: some View {
        NavigationView{
            if self.pageClient.favoriteSongs.isEmpty{
                ScrollView{
                    HStack{
                        Text("LOCAL_FAVORITE_EMPTY")
                            .font(.title2)
                        Image(systemName: "heart.slash")
                            .font(.title2)
                            .foregroundColor(.accentColor)
                    }.padding(.vertical,35.0.responsiveH)
                }.navigationTitle(LocalizedStringKey("LOCAL_FAVORITE_TITLE"))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                self.isHide.toggle()
                            } label: {
                                Image(systemName: "person.circle")
                                    .foregroundColor(.accentColor)
                            }.sheet(isPresented: self.$isHide, onDismiss: nil) {
                                AccountView(isHide: self.$isHide)
                            }
                        }
                    }
                    
            }else{
                List(0..<self.pageClient.favoriteSongs.count) { a in
                    OneSongExpandedView(listSong: self.pageClient.favoriteSongs[a], index: a, inList: true)
                }.listStyle(.plain)
                    .refreshable {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.pageClient.updateSongs()
                        }
                    }
                    .navigationTitle(LocalizedStringKey("LOCAL_FAVORITE_TITLE"))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                self.isHide.toggle()
                            } label: {
                                Image(systemName: "person.circle")
                                    .foregroundColor(.accentColor)
                            }.sheet(isPresented: self.$isHide, onDismiss: nil) {
                                AccountView(isHide: self.$isHide)
                            }
                        }
                    }
            }
        }.onAppear {
            self.pageClient.updateSongs()
        }
        .onDisappear {
            self.pageClient.updateSongs()
        }
        
    }
}

struct FavoriteListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListView()
    }
}
