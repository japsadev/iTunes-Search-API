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
            ScrollView(.horizontal){
                HStack{
                    ForEach(0..<5){_ in
                        VStack(alignment:.leading){
                            ZStack{
                                Rectangle()
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .foregroundColor(.primary.opacity(0.1))
                                    .cornerRadius(5)
                                ProgressView()
                            }
                            HStack{
                                Rectangle()
                                    .frame(width: 85, height: 20, alignment: .center)
                                    .foregroundColor(.primary.opacity(0.1))
                                    .cornerRadius(5)
                                Spacer()
                            }.padding(.trailing)
                            HStack{
                                Rectangle()
                                    .frame(width: 50, height: 15, alignment: .center)
                                    .foregroundColor(.primary.opacity(0.1))
                                    .cornerRadius(5)
                                Spacer()
                            }.padding(.trailing)
                        }
                    }
                }
            }.padding(.leading)
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

struct SongScroolView_Preview : PreviewProvider{
    static var previews: some View{
        PopularView()
    }
}
