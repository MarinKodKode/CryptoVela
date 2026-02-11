//
//  CryptoModels.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 10/02/26.
//

import Foundation

// MARK: - Generic Response Wrapper
struct CoinCapResponse<T: Decodable>: Decodable {
    let data: T
    let timestamp: Int64?
}

// MARK: - Asset (Crypto)
struct Asset: Codable, Identifiable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let supply: String?
    let maxSupply: String?
    let marketCapUsd: String?
    let volumeUsd24Hr: String?
    let priceUsd: String
    let changePercent24Hr: String?
    let vwap24Hr: String?
    let explorer: String?
    
    // Computed properties for easier usage
    var price: Double {
        Double(priceUsd) ?? 0.0
    }
    
    var changePercent: Double {
        Double(changePercent24Hr ?? "0") ?? 0.0
    }
    
    var marketCap: Double {
        Double(marketCapUsd ?? "0") ?? 0.0
    }
    
    var volume24h: Double {
        Double(volumeUsd24Hr ?? "0") ?? 0.0
    }
    
    var rankInt: Int {
        Int(rank) ?? 0
    }
    
    var isPositiveChange: Bool {
        changePercent >= 0
    }
    
    // Formatted values
    var formattedPrice : String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = price < 1 ? 4 : 2
        return formatter.string(from: NSNumber(value: price)) ?? "$0.00"
    }
    
    var formattedChange: String {
        let sign = isPositiveChange ? "+" : ""
        return String(format: "\(sign)%.2f%%", changePercent)
    }
    
    var formattedMarketCap: String {
        formatLargeNumber(marketCap)
    }
    
    var formattedVolume: String {
        formatLargeNumber(volume24h)
    }
    
    private func formatLargeNumber(_ value: Double) -> String {
        let billion = 1_000_000_000.0
        let million = 1_000_000.0
        
        if value >= billion {
            return String(format: "$%.2fB", value / billion)
        } else if value >= million {
            return String(format: "$%.2fM", value / million)
        } else {
            return String(format: "$%.2fK", value / 1000.0)
        }
    }
}

// MARK: - History Data Point
struct HistoryDataPoint: Codable, Identifiable {
    let priceUsd: String
    let time: Int64
    let date: String?
    
    var id: Int64 { time }
    
    var price: Double {
        Double(priceUsd) ?? 0.0
    }
    
    var timestamp: Date {
        Date(timeIntervalSince1970: TimeInterval(time / 1000))
    }
}

// MARK: - Market
struct Market: Codable, Identifiable {
    let exchangeId: String
    let baseId: String
    let quoteId: String
    let baseSymbol: String
    let quoteSymbol: String
    let volumeUsd24Hr: String?
    let priceUsd: String?
    let volumePercent: String?
    
    var id: String { exchangeId + baseId + quoteId }
    
    var volume: Double {
        Double(volumeUsd24Hr ?? "0") ?? 0.0
    }
    
    var price: Double {
        Double(priceUsd ?? "0") ?? 0.0
    }
}

// MARK: - Rate
struct Rate: Codable, Identifiable {
    let id: String
    let symbol: String
    let currencySymbol: String?
    let type: String
    let rateUsd: String
    
    var rate: Double {
        Double(rateUsd) ?? 0.0
    }
}
