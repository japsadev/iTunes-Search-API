//
//  SongsScrollView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 25.01.2022.
//

import SwiftUI

struct SongsScrollView: View {
    @ObservedObject private var pageClient : PopularSongClient
    
    init(contentKey: String){
        self.pageClient = PopularSongClient(contentKey: contentKey)
    }
    var body: some View {
        
        if self.pageClient.popularSongs.isEmpty{
            ProgressView()
        }else{
            ScrollView(.horizontal){
                HStack(spacing:13){
                    ForEach(self.pageClient.popularSongs) { song in
                        LitteSongView(song: song)
                    }
                }.padding(.bottom)
            }.padding(.leading)
        }
    }
}
