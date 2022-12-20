//
//  InformationFieldsView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 6.02.2022.
//

import SwiftUI

struct InformationFieldsView: View {
    @Binding var value: String
    var title: String
    var hint: String

    var body: some View {
        HStack(spacing: 0) {
            Text(LocalizedStringKey(title))
            TextField(LocalizedStringKey(hint), text: self.$value)
        }
    }
}
