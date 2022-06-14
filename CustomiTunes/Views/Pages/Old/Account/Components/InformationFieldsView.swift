//
//  InformationFieldsView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 6.02.2022.
//

import SwiftUI

struct InformationFieldsView: View {
    var title : String
    var hint : String
    
    let defaults = UserDefaults.standard
    
    @Binding var value : String{
        didSet{
            defaults.set(value, forKey: title)
        }
    }
    
    var body: some View {
        HStack(spacing:0){
            Text(LocalizedStringKey(title))
            TextField(LocalizedStringKey(hint), text: self.$value)
                .onChange(of: self.value, perform: { newValue in
                    self.value = newValue
                })
        }.onAppear {
            self._value.wrappedValue = self.defaults.string(forKey: title) ?? ""
        }
    }
}
