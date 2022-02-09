//
//  OneSongExpandedView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 9.02.2022.
//

import SwiftUI

struct OneSongExpandedView: View {
    var listSong : SongsExpandedViewModel
    var index : Int
    var inList : Bool
    var body: some View {
        NavigationLink {
            SongDetailView(detailSongId: listSong.id)
        } label: {
            VStack(alignment:.leading,spacing:5){
                HStack{
                    Text(String(self.index + 1))
                        .frame(width: 7.0.responsiveW)
                    AsyncImage(url:listSong.songImage) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 10)
                    }.frame(width: 15.0.responsiveW, height: 15.0.responsiveW, alignment: .center)
                    VStack(alignment:.leading){
                        HStack{
                            Text(listSong.songName)
                                .font(.title3)
                            ExplicitView(explicitState: listSong.trackExplicitness)
                        }
                        Text(listSong.singerName)
                            .font(.callout)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    Spacer()
                    if !self.inList{
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color("ThemeColor"))
                    }
                }
                if !self.inList{
                    Divider()
                }
            }.frame(width: !self.inList ? 95.0.responsiveW : 80.0.responsiveW, height: 15.0.responsiveW, alignment: .center)
                .foregroundColor(.primary)
        }
    }
}

struct OneSongExpandedView_Previews: PreviewProvider {
    static var previews: some View {
        SongsExpandedView(contentKey: "turkeySongs", pageTitle: "Yükselenler: Türkiye")
    }
}
