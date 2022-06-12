//
//  CircleButtonView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 7.02.2022.
//

import SwiftUI

struct ActionButtonView: View {
    @Binding private var isValue: Bool
    private var activeIcon: String
    private var disActiveIcon: String
    private var activeTitle : String
    private var disActiveTitle: String
    private var buttonWidth : CGFloat
    private var buttonAction: () -> Void
    
    init(isValue: Binding<Bool>? = .constant(true), activeIcon: String, disActiveIcon: String? = "", activeTitle: String, disActiveTitle: String? = "", buttonWidth: CGFloat? = 29.0.responsiveW, buttonAction: @escaping () -> Void){
        self._isValue = isValue!
        self.activeIcon = activeIcon
        self.disActiveIcon = disActiveIcon!
        self.activeTitle = activeTitle
        self.disActiveTitle = disActiveTitle!
        self.buttonWidth = buttonWidth!
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        Button(action: buttonAction) {
            HStack{
                Text(self.isValue ? LocalizedStringKey(activeTitle) : LocalizedStringKey(disActiveTitle))
                Image(systemName: self.isValue ? activeIcon : disActiveIcon)
            }.padding(10)
                .frame(width: self.buttonWidth, height: 5.0.responsiveH)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
        }
    }
}
