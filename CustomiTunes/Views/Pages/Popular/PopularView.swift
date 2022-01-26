//
//  PopularView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 25.01.2022.
//

import SwiftUI

struct PopularView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    HStack{
                        Text("Music")
                            .font(.title)
                            .bold()
                            .padding(.leading)
                        Spacer()
                    }
                    SongsScrollView()
                }
                VStack{
                    HStack{
                        Text("Movie")
                            .font(.title)
                            .bold()
                            .padding(.leading)
                        Spacer()
                    }
                    SongsScrollView()
                }
                VStack{
                    HStack{
                        Text("Ebook")
                            .font(.title)
                            .bold()
                            .padding(.leading)
                        Spacer()
                    }
                    SongsScrollView()
                }
            }.navigationTitle("Popular Content")
            
        }
    }
}

struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        PopularView()
    }
}
