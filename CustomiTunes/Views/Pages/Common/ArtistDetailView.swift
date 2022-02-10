//
//  ArtistDetailView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 9.02.2022.
//

import SwiftUI

struct ArtistDetailView: View {
    @ObservedObject private var pageClient = ArtistDetailClient()
    
    var artistID : Double
    var artistName : String
    @State private var isShow = false
    
    var body: some View {
        ScrollView{
            if !self.pageClient.artistSongs.isEmpty{
                if !self.pageClient.artistAlbum.isEmpty{
                    AsyncImage(url: self.pageClient.artistAlbum[0].artistImage) { image in
                        image.resizable()
                            .frame(width: 100.0.responsiveW, height: 45.0.responsiveH, alignment: .center)
                            .aspectRatio(contentMode: .fill)
                            .padding(.bottom,5)
                    } placeholder: {
                        ZStack{
                            Rectangle()
                                .foregroundColor(.secondary.opacity(0.1))
                                .frame(width: 100.0.responsiveW, height: 45.0.responsiveH, alignment: .center)
                                .padding(.bottom,5)
                            ProgressView()
                        }
                    }
                }else{
                    ZStack{
                        Rectangle()
                            .foregroundColor(.secondary.opacity(0.1))
                            .frame(width: 100.0.responsiveW, height: 30.0.responsiveH, alignment: .center)
                        ProgressView()
                    }
                }
                HStack{
                    ActionButtonView(buttonAction: {
                        self.isShow.toggle()
                        print(self.pageClient.artistSongs[0])
                    }, isValue: self.$isShow, activeIcon: "safari", disActiveIcon: "safari", disActiveTitle: "LOCAL_ARTIST_WEB_VIEW", activeTitle: "LOCAL_ARTIST_WEB_VIEW",buttonWidth: 45.0.responsiveW)
                        .sheet(isPresented: self.$isShow, onDismiss: nil) {
                            WebView(url: self.pageClient.artistSongs[0].artistPreview)
                        }
                    ActionButtonView(buttonAction: {
                        let shareMusic = UIActivityViewController(activityItems: [self.pageClient.artistSongs[0].artistPreview], applicationActivities: nil)
                        if let vc = UIApplication.shared.windows.first?.rootViewController{
                            vc.present(shareMusic,animated: true)
                        }
                    }, isValue: self.$isShow, activeIcon: "square.and.arrow.up", disActiveIcon: "square.and.arrow.up", disActiveTitle: "LOCAL_ARTIST_SHARE", activeTitle: "LOCAL_ARTIST_SHARE",buttonWidth: 45.0.responsiveW)
                }.padding(.bottom,5)
                
                ForEach(self.pageClient.artistSongs){ song in
                    ListSongView(listSong: song)
                }
            }else{
                ProgressView()
            }
        }.navigationTitle(NSLocalizedString("LOCAL_ARTIST_ALL_1", comment: "for localize artist name") + self.artistName + NSLocalizedString("LOCAL_ARTIST_ALL_2", comment: "for localize artist name"))
            .onAppear(perform: {
                self.pageClient.getArtistImage(for: self.artistID)
                self.pageClient.searchBySingerID(for: self.artistID,limit: 100)
            })
    }
}

struct ArtistDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PopularView()
    }
}
