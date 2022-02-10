//
//  CircleButtonView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 7.02.2022.
//

import SwiftUI

struct ActionButtonView: View {
    var buttonAction: () -> Void
    @Binding var isValue: Bool
    var activeIcon: String
    var disActiveIcon: String
    var disActiveTitle: String
    var activeTitle : String
    var buttonWidth : CGFloat? = 29.0.responsiveW
    
    var body: some View {
        Button(action: buttonAction) {
            HStack{
                Text(self.isValue ? LocalizedStringKey(activeTitle) : LocalizedStringKey(disActiveTitle))
                Image(systemName: self.isValue ? activeIcon : disActiveIcon)
            }.padding(10)
                .frame(width: self.buttonWidth,height: 5.0.responsiveH)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
        }
    }
}
