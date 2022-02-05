//
//  SearchBarView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 5.02.2022.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchKey : String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 95.0.responsiveW, height: 7.0.responsiveH, alignment: .center)
                .foregroundColor(.gray.opacity(0.3))
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .padding(.leading,5)
                TextField("Search", text: self.$searchKey)
                    .keyboardType(.webSearch)
            }.padding()
        }
    }
}
