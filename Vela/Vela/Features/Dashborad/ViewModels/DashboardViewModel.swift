//
//  DashboardViewModel.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 10/02/26.
//

import Foundation
internal import Combine

@MainActor
final class DashboardViewModel: ObservableObject {

    // MARK: - Published State

    @Published var coins: [Coin] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""

    // MARK: - Dependencies

    private let cryptoService: CryptoServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Filtered coins

    var filteredCoins: [Coin] {
        guard !searchText.isEmpty else { return coins }

        return coins.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.symbol.localizedCaseInsensitiveContains(searchText)
        }
    }

    // MARK: - Init

    init(cryptoService: CryptoServiceProtocol = CryptoService()) {
        self.cryptoService = cryptoService
    }

    // MARK: - Load

    func loadCoins() async {
        isLoading = true
        errorMessage = nil

        do {
            coins = try await cryptoService.fetchTopCoins(limit: 50)
        } catch {
            handleError(error)
        }

        isLoading = false
    }

    func refresh() async {
        await loadCoins()
    }

    // MARK: - Error handling

    func clearError() {
        errorMessage = nil
    }

    private func handleError(_ error: Error) {
        if let apiError = error as? APIError {
            errorMessage = apiError.localizedDescription
        } else {
            errorMessage = error.localizedDescription
        }
    }
}
