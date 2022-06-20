//
//  TrackListView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 20.06.2022.
//

import SwiftUI

struct TrackListView: View {
    @ObservedObject private var viewModel: TrackListViewModel = TrackListViewModel()
    var contentKey: String
    var pageTitle: String
    
    var body: some View {
        if viewModel.pageState == .loading{
            VStack{
                ProgressView()
            }.onAppear{
                viewModel.getListTracks(by: contentKey)
            }
        }else{
            ScrollView{
                ForEach(viewModel.trackList, id: \.self.wrappedId){ track in
                    ListSongView(songData: track)
                }.frame(width: 100.0.responsiveW)
            }.navigationTitle(LocalizedStringKey(self.pageTitle))
        }
    }
}

struct TrackListView_Previews: PreviewProvider {
    static var previews: some View {
        TrackListView(contentKey: "usaSongs", pageTitle: "Turkey")
    }
}
