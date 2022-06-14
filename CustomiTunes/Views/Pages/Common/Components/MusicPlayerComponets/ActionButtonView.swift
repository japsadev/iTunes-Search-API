//
//  CircleButtonView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 7.02.2022.
//

import SwiftUI

struct ActionButtonView: View {
    @Binding private var isValue: ActionButtonState
    private var activeIcon: String
    private var disActiveIcon: String
    private var activeTitle : String
    private var disActiveTitle: String
    private var buttonWidth : CGFloat
    private var buttonAction: () -> Void
    
    init(isValue: Binding<ActionButtonState>? = .constant(.active), activeIcon: String, disActiveIcon: String? = "", activeTitle: String, disActiveTitle: String? = "", buttonWidth: CGFloat? = 29.0.responsiveW, buttonAction: @escaping () -> Void){
        self._isValue = isValue!
        self.activeIcon = activeIcon
        self.disActiveIcon = disActiveIcon!
        self.activeTitle = activeTitle
        self.disActiveTitle = disActiveTitle!
        self.buttonWidth = buttonWidth!
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        let stateProperties = setButtonTextByState()
        
        Button(action: buttonAction) {
            HStack{
                if isValue == .inProgress{
                    ProgressView()
                        .tint(.accentColor)
                }else{
                    Text(stateProperties.textValue)
                    Image(systemName: stateProperties.iconValue)
                }
            }.padding()
                .frame(width: self.buttonWidth, height: 5.0.responsiveH)
                .foregroundColor(stateProperties.contentColor)
                .overlay(isValue == .active ? nil : RoundedRectangle(cornerRadius: 10).stroke())
                .background(isValue == .active ? RoundedRectangle(cornerRadius: 10) : nil)
                .font(.footnote)
        }
    }
    
    func setButtonTextByState() -> (textValue: String, iconValue: String, contentColor: Color){
        if isValue == .active{
            return (textValue: activeTitle, iconValue: activeIcon, contentColor: .white)
        } else {
            return (textValue: disActiveTitle, iconValue: disActiveIcon, contentColor: .red)
        }
    }
}

struct ActionButtonView_Preview: PreviewProvider{
    static var previews: some View{
        ActionButtonView(isValue: .constant(.active), activeIcon: "play", disActiveIcon: "pause", activeTitle: "Play", disActiveTitle: "Pause") {
        }
    }
}

enum ActionButtonState{
    case active
    case inProgress
    case disActive
}
