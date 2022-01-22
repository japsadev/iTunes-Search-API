//
//  ContentView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 22.01.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var popular = PopularViewClient()
    var body: some View {
        ScrollView{
            ForEach(self.popular.songs) { song in
                HStack{
                    Text(song.songName)
                    Text("+")
                    Text(song.singerName)
                }
                
            }
        }.padding(.bottom,5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
