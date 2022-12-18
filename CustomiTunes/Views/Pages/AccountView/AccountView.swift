//
//  AccountView.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 6.02.2022.
//

import SwiftUI

struct AccountView: View {
    @StateObject private var viewModel: AccountViewModel = AccountViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            List {
                Section(LocalizedStringKey("LOCAL_ACCOUNT_INFO")) {
                    InformationFieldsView(value: $viewModel.userPreference.name, title: "LOCAL_ACCOUNT_NAME", hint: "LOCAL_ACCOUNT_NAME_HINT")
                    InformationFieldsView(value: $viewModel.userPreference.surname, title: "LOCAL_ACCOUNT_SURNAME", hint: "LOCAL_ACCOUNT_SURNAME_HINT")
                    InformationFieldsView(value: $viewModel.userPreference.email, title: "LOCAL_ACCOUNT_EMAIL", hint: "LOCAL_ACCOUNT_EMAIL_HINT")
                }
                Section(LocalizedStringKey("LOCAL_ACCOUNT_SETTINGS")) {
                    ToogleSettingsView(value: $viewModel.userPreference.notifications, title: "LOCAL_ACOOUNT_NOTIFICATION")
                }
                Section(LocalizedStringKey("LOCAL_ACCOUNT_PRIVACY")) {
                    ToogleSettingsView(value: $viewModel.userPreference.privacy, title: "LOCAL_ACCOUNT_SHARE_DATA")
                }
            }.listStyle(.grouped)
            .navigationTitle("LOCAL_ACCOUNT_TITLE")
                .toolbar {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply.circle")
                            .foregroundColor(.accentColor)
                    }
                }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
