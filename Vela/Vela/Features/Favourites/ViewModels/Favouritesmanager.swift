//
//  FavouritesViewModel.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 10/02/26.
//

import Foundation
internal import Combine

final class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()
    
    @Published private(set) var favoriteIds: Set<String> = []
    
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "savedCryptos"
    
    private init() {
        loadFavorites()
    }
    
    func isFavorite(_ assetId: String) -> Bool {
        favoriteIds.contains(assetId)
    }
    
    func toggleFavorite(_ assetId: String) {
        if favoriteIds.contains(assetId) {
            favoriteIds.remove(assetId)
        } else {
            favoriteIds.insert(assetId)
        }
        saveFavorites()
    }
    
    func addFavorite(_ assetId: String) {
        favoriteIds.insert(assetId)
        saveFavorites()
    }
    
    func removeFavorite(_ assetId: String) {
        favoriteIds.remove(assetId)
        saveFavorites()
    }
    
    private func saveFavorites() {
        let array = Array(favoriteIds)
        userDefaults.set(array, forKey: favoritesKey)
    }
    
    private func loadFavorites() {
        if let saved = userDefaults.array(forKey: favoritesKey) as? [String] {
            favoriteIds = Set(saved)
        }
    }
}
