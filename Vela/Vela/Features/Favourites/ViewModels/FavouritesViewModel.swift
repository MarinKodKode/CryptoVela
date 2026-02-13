//
//  FavoritesViewModel.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 10/02/26.
//

import Foundation
internal import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {

    // MARK: - Published State

    @Published var favoriteCoins: [Coin] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Dependencies

    private let cryptoService: CryptoServiceProtocol
    private let favoritesManager: FavoritesManager
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    init(
        cryptoService: CryptoServiceProtocol = CryptoService(),
        favoritesManager: FavoritesManager = .shared
    ) {
        self.cryptoService = cryptoService
        self.favoritesManager = favoritesManager

        observeFavorites()
    }

    // MARK: - Favorites observation

    private func observeFavorites() {
        favoritesManager.$favoriteIds
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                Task {
                    await self?.loadFavorites()
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - Load favorites

    func loadFavorites() async {
        let favoriteUUIDs = Array(favoritesManager.favoriteIds)

        guard !favoriteUUIDs.isEmpty else {
            favoriteCoins = []
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            var coins: [Coin] = []

            try await withThrowingTaskGroup(of: Coin.self) { group in
                for uuid in favoriteUUIDs {
                    group.addTask {
                        try await self.cryptoService.fetchCoin(by: uuid)
                    }
                }

                for try await coin in group {
                    coins.append(coin)
                }
            }

            // Orden sugerido: market cap (más real que rank)
            favoriteCoins = coins.sorted {
                (Double($0.marketCap ?? "0") ?? 0) >
                (Double($1.marketCap ?? "0") ?? 0)
            }

        } catch {
            handleError(error)
        }

        isLoading = false
    }

    // MARK: - Actions

    func removeFavorite(_ coin: Coin) {
        favoritesManager.removeFavorite(coin.uuid)
    }

    func clearError() {
        errorMessage = nil
    }

    // MARK: - Error handling

    private func handleError(_ error: Error) {
        if let apiError = error as? APIError {
            errorMessage = apiError.localizedDescription
        } else {
            errorMessage = error.localizedDescription
        }
    }
}
