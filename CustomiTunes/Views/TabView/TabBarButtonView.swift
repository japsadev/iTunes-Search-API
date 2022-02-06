//
//  TabBarButtonView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 22.01.2022.
//

import SwiftUI

struct TabBarButtonView: View {
    var title : String
    var image : String
    @Binding var currentTab : String
    
    var body: some View{
        Button{
            withAnimation{
                currentTab = title
            }
        }label: {
            VStack(spacing : 5) {
                Image(systemName: image).font(.title2)
                    .frame(height: 25)
                Text(LocalizedStringKey(title)).font(.caption).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
            .foregroundColor(title == currentTab ? Color("ThemeColor") : .secondary)
            .frame(maxWidth: .infinity)
        }
    }
}
