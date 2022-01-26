//
//  SongsScrollView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 25.01.2022.
//

import SwiftUI

struct SongsScrollView: View {
    @ObservedObject private var pageclient = PopularSongClient()
    var body: some View {
        
        if self.pageclient.popularSongs.isEmpty{
            ProgressView()
        }else{
            ScrollView(.horizontal){
                HStack{
                    ForEach(self.pageclient.popularSongs) { song in
                        LitteSongView(song: song)
                    }
                }
            }.padding(.leading)
        }
    }
}
