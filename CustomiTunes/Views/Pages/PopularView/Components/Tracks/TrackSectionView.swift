//
//  TrackSectionView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 16.06.2022.
//

import SwiftUI

struct TrackSectionView: View {
    @EnvironmentObject private var viewModel: PopularViewModel
    let title: String
    let contentKey: String
    
    var body: some View {
        VStack(spacing: 0){
            // MARK: Title and navigation link
            HStack{
                Text(LocalizedStringKey(title))
                    .font(.largeTitle)
                    .bold()
                Spacer()
                NavigationLink {
                    TrackListView(contentKey: contentKey, pageTitle: title)
                } label: {
                    HStack(spacing: 5){
                        Text(LocalizedStringKey("LOCAL_DETAIL"))
                        Image(systemName: "chevron.right")
                            .font(.caption)
                    }
                }
            }.padding()
            
            // MARK: Track List
            ScrollView(.horizontal){
                HStack(spacing: 0){
                    ForEach(viewModel.songsByKey[contentKey] ?? [], id: \.self.wrappedId) { track in
                        NavigationLink {
                            SongDetailView(songId: track.wrappedId)
                        } label: {
                            SmallTrackView(trackData: track)
                                .padding([.leading, .bottom])
                        }.buttonStyle(.plain)
                    }
                    Rectangle()
                        .frame(width: 0, height: 0)
                        .padding(.trailing)
                }
            }
        }.onAppear{
            self.viewModel.getTracksByKey(contentKey)
        }
    }
}

struct TrackSectionView_Previews: PreviewProvider {
    static var previews: some View {
        TrackSectionView(title: "LOCAL_COUNTRY_RISERS", contentKey: "LOCAL_COUNTRY_LIST_KEY")
    }
}
