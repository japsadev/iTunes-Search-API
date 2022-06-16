//
//  ExplicitView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 29.01.2022.
//

import SwiftUI

struct ExplicitView: View {
    let explicitState : String
    var body: some View {
        if let firstLabel = explicitState.first?.uppercased(){
            if firstLabel == "E" || firstLabel == "C"{
                Text(firstLabel)
                    .font(.caption2)
                    .foregroundColor(.primary)
                    .frame(width: 4.5.responsiveW, height: 4.5.responsiveW, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 2).foregroundColor(.gray))
            }
        }
    }
}

struct ExplicitView_Previews: PreviewProvider {
    static var previews: some View {
        ExplicitView(explicitState: "exclicit")
    }
}
