//
//  AccountView-ViewModel.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 18.06.2022.
//

import Foundation

@MainActor class AccountViewModel: ObservableObject{
    @Published var name = ""{
        didSet{
            saveData()
        }
    }
    @Published var surname = ""{
        didSet{
            saveData()
        }
    }
    
    @Published var email = ""{
        didSet{
            saveData()
        }
    }
    
    
    @Published var notificationSettings = true{
        didSet{
            saveData()
        }
    }
    
    @Published var dataPrivacy = true{
        didSet{
            saveData()
        }
    }
    
    private let saveKey = "accountPreference"
    
    func saveData(){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let fileURL = dir.appendingPathComponent(saveKey)
            
            do{
                let model = PreferenceModel(name: name, surname: surname, email: email, notifications: notificationSettings, privacy: dataPrivacy)
                
                if let encoded = try? JSONEncoder().encode(model) {
                    try encoded.write(to: fileURL)
                }
            } catch{ print("save error") }
        }
    }
    
    func readData(){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let fileURL = dir.appendingPathComponent(saveKey)
            
            do{
                let stringContent = try String(contentsOf: fileURL, encoding: .utf8)
                if let decoded = try? JSONDecoder().decode(PreferenceModel.self, from: stringContent.data(using: .utf8) ?? Data()) {
                    self.name = decoded.name
                    self.surname = decoded.surname
                    self.email = decoded.email
                    self.notificationSettings = decoded.notifications
                    self.dataPrivacy = decoded.privacy
                }
            } catch{ print("read error") }
        }
    }
    
    init(){
        readData()
    }
}

private struct PreferenceModel: Codable{
    var name: String
    var surname: String
    var email: String
    var notifications: Bool
    var privacy: Bool
}
