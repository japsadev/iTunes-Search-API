//
//  ToogleSettingsView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 6.02.2022.
//

import SwiftUI

struct ToogleSettingsView: View {
    @Binding var value : Bool
    var title : String
    
    var body: some View {
        Toggle(LocalizedStringKey(title), isOn: self.$value)
            .onChange(of: self.value) { newValue in
                self.value = newValue
            }
    }
}
