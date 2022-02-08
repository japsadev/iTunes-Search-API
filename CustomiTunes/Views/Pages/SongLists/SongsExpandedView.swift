//
//  SongExpandedView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 6.02.2022.
//

import SwiftUI

struct SongsExpandedView: View {
    @ObservedObject private var pageClient : SongsExpandedClient
    private var pageTitle : String
    
    init(contentKey: String, pageTitle : String){
        self.pageClient = SongsExpandedClient(contentKey: contentKey)
        self.pageTitle = pageTitle
    }
    var body: some View {
        if self.pageClient.listSongs.isEmpty{
           ProgressView()
        }else{
            ScrollView{
                ForEach(0..<self.pageClient.listSongs.count){ i in
                    OneSongExpandedView(listSong: self.pageClient.listSongs[i], index: i)
                }
            }.navigationTitle(LocalizedStringKey(self.pageTitle))
        }


    }
}

struct SongExpandedView_Previews: PreviewProvider {
    static var previews: some View {
        SongsExpandedView(contentKey: "turkeySongs",pageTitle: "Yükselenler: Türkiye")
    }
}
