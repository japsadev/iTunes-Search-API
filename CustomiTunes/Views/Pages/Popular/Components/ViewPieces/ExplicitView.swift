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
        if explicitState.first!.lowercased() == "e"{
            ZStack{
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 15, height: 15, alignment: .center)
                    .foregroundColor(.secondary)
                Text("E")
                    .font(.caption2)
                    .foregroundColor(.primary)
            }
        }else if explicitState.first!.lowercased() == "c"{
            ZStack{
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 15, height: 15, alignment: .center)
                    .foregroundColor(.secondary)
                Text("C")
                    .font(.caption2)
                    .foregroundColor(.primary)
            }
        }
    }
}

struct ExplicitView_Previews: PreviewProvider {
    static var previews: some View {
        ExplicitView(explicitState: "exclicit")
    }
}
