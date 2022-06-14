//
//  ToogleSettingsView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 6.02.2022.
//

import SwiftUI

struct ToogleSettingsView: View {
    var title : String
    let defaults = UserDefaults.standard
    
    @Binding var value : Bool{
        didSet{
            defaults.set(value, forKey: title)
        }
    }
    
    var body: some View {
        Toggle(LocalizedStringKey(title), isOn: self.$value)
            .onChange(of: self.value) { newValue in
                self.value = newValue
            }.onAppear {
                self._value.wrappedValue = self.defaults.bool(forKey: title)
            }
    }
}

//struct ToogleSettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ToogleSettingsView()
//    }
//}
