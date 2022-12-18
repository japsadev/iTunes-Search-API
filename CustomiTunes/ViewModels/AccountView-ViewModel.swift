//
//  AccountView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 18.06.2022.
//

import Foundation

@MainActor class AccountViewModel: ObservableObject {
    @Published var userPreference: PreferenceModel = PreferenceModel(name: "", surname: "", email: "", notifications: false, privacy: false) {
        didSet {
            saveData()
        }
    }
    private let saveKey = "accountPreference"

    func saveData() {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(saveKey)

            do {
                if let encoded = try? JSONEncoder().encode(userPreference) {
                    try encoded.write(to: fileURL)
                }
            } catch { print("save error") }
        }
    }

    func readData() {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(saveKey)

            do {
                let stringContent = try String(contentsOf: fileURL, encoding: .utf8)
                if let decoded = try? JSONDecoder().decode(PreferenceModel.self, from: stringContent.data(using: .utf8) ?? Data()) {
                    self.userPreference = decoded
                }
            } catch { print("read error") }
        }
    }

    init() {
        readData()
    }
}

struct PreferenceModel: Codable {
    var name: String
    var surname: String
    var email: String
    var notifications: Bool
    var privacy: Bool
}
