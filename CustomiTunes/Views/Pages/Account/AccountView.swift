//
//  AccountView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 6.02.2022.
//

import SwiftUI

struct AccountView: View {
    @Binding var isHide : Bool
    
    @State private var notificationSettings = true
    @State private var dataPrivacy = true
    
    @State private var name = ""
    @State private var surname = ""
    @State private var email = ""
    
    var body: some View {
        NavigationView{
            List{
                Section(LocalizedStringKey("LOCAL_ACCOUNT_INFO")){
                    InformationFieldsView(title: "LOCAL_ACCOUNT_NAME", hint: "LOCAL_ACCOUNT_NAME_HINT", value: self.$name)
                    InformationFieldsView(title: "LOCAL_ACCOUNT_SURNAME", hint: "LOCAL_ACCOUNT_SURNAME_HINT", value: self.$surname)
                    InformationFieldsView(title: "LOCAL_ACCOUNT_EMAIL", hint: "LOCAL_ACCOUNT_EMAIL_HINT", value: self.$email)
                }
                Section(LocalizedStringKey("LOCAL_ACCOUNT_SETTINGS")){
                    ToogleSettingsView(title: "LOCAL_ACOOUNT_NOTIFICATION", value: self.$notificationSettings)
                }
                Section(LocalizedStringKey("LOCAL_ACCOUNT_PRIVACY")){
                    ToogleSettingsView(title: "LOCAL_ACCOUNT_SHARE_DATA", value: self.$dataPrivacy)
                }
            }.listStyle(.grouped)
            .navigationTitle("LOCAL_ACCOUNT_TITLE")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    Button {
                        self.isHide.toggle()
                    } label: {
                        Image(systemName: "multiply.circle")
                            .foregroundColor(Color("ThemeColor"))
                    }
                }
        }
    }
}

//struct AccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView()
//    }
//}
