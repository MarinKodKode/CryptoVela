//
//  CryptoService.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 10/02/26.
//

import Foundation

// MARK: - Protocol

protocol CryptoServiceProtocol {
    func fetchTopCoins(limit: Int) async throws -> [Coin]
    func fetchCoin(by uuid: String) async throws -> Coin
    func fetchHistory(
        coinUUID: String,
        interval: TimePeriod
    ) async throws -> [HistoryPoint]
}

final class CryptoService: CryptoServiceProtocol {

    private let apiClient = APIClient.shared

    func fetchTopCoins(limit: Int) async throws -> [Coin] {
        let response = try await apiClient.request(
            endpoint: CoinRankingEndpoint.coins(limit: limit, offset: 12),
            responseType: CoinRankingResponse<CoinsContainer>.self
        )

        return response.data.coins
    }

    func fetchCoin(by uuid: String) async throws -> Coin {
        let response = try await apiClient.request(
            endpoint: CoinRankingEndpoint.coin(uuid: uuid),
            responseType: CoinRankingResponse<CoinContainer>.self
        )

        return response.data.coin
    }

    func fetchHistory(
        coinUUID: String,
        interval: TimePeriod
    ) async throws -> [HistoryPoint] {

        let response = try await apiClient.request(
            endpoint: CoinRankingEndpoint
                .coinHistory(uuid: coinUUID, period: interval),
            responseType: CoinRankingResponse<HistoryContainer>.self
        )

        return response.data.history.compactMap {
            guard
                let price = Double("\($0.price)")
            else { return HistoryPoint(timestamp: .now, price: 0.0) }

            return HistoryPoint(
                timestamp: Date.now,
                price: price
            )
        }
    }
}


struct CoinContainer: Decodable {
    let coin: Coin
}

struct HistoryContainer: Decodable {
    let history: [HistoryPoint]
}



enum HistoryInterval: String, CaseIterable {
    case m15 = "15m"
    case h1 = "1h"
    case h6 = "6h"
    case h12 = "12h"
    case d1 = "24h"
}

struct HistoryPoint: Identifiable, Decodable {
    let id = UUID()
    let timestamp: Date
    let price: Double
}

struct HistoryDTO: Decodable {
    let price: String
    let timestamp: Int
}
