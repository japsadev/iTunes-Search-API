//
//  HScroolWithTitleView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 29.01.2022.
//

import SwiftUI

struct HScroolWithTitleView: View {
    let title : String
    let contentKey : String
    var body: some View {
        VStack{
            HStack{
                Text(LocalizedStringKey(title))
                    .font(.title)
                    .bold()
                    .padding(.leading)
                Spacer()
                Button {
                    
                } label: {
                    HStack(alignment:.center,spacing:3){
                        Text("LOCAL_DETAIL")
                        Image(systemName: "chevron.right")
                            .font(.callout)
                    }
                }.padding(.trailing)
                    .foregroundColor(Color("ThemeColor"))
            }
            SongsScrollView(contentKey: self.contentKey)
        }
    }
}

struct HScroolWithTitleView_Previews: PreviewProvider {
    static var previews: some View {
        HScroolWithTitleView(title:"Music",contentKey: "")
    }
}
