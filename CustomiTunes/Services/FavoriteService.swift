//
//  FavoriteService.swift
//  CustomiTunes
//
//  Created by Mehmet Ateş on 19.06.2022.
//

import Foundation

class FavoriteService: ObservableObject {
    private let saveKey = "favoriteTracks"
    @Published var favoriteTrackIds: [Double] = [] {
        didSet {
            saveFavorites()
        }
    }

    func saveFavorites() {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(saveKey)

            do {
                if let encoded = try? JSONEncoder().encode(favoriteTrackIds) {
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
                if let decoded = try? JSONDecoder().decode([Double].self, from: stringContent.data(using: .utf8) ?? Data()) {
                    self.favoriteTrackIds = decoded
                }
            } catch { print("read error"); self.favoriteTrackIds = [] }
        }
    }

    func addOrRemoveFavorite(_ id: Double) {
        let isContains = favoriteTrackIds.contains { $0 == id }
        if isContains {
            if let firstIndex = favoriteTrackIds.firstIndex(of: id) {
                favoriteTrackIds.remove(at: firstIndex)
            }
        } else {
            favoriteTrackIds.append(id)
        }
    }

    func isFavorite(_ id: Double) -> Bool {
        favoriteTrackIds.contains { $0 == id }
    }

    init() {
        readData()
    }
}
