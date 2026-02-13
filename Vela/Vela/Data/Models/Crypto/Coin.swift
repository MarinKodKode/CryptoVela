import Foundation
import SwiftUI

struct Coin: Identifiable, Decodable {
    
    // MARK: - Raw API values
    
    let uuid: String
    let symbol: String
    let name: String
    let price: String
    let change: String
    let marketCap: String?
    let volume24h: String?
    
    // MARK: - Identifiable
    
    var id: String { uuid }
    
    // MARK: - Computed values for UI
    
    var priceDouble: Double {
        Double(price) ?? 0
    }
    
    var changeDouble: Double {
        Double(change) ?? 0
    }
    
    var marketCapDouble: Double {
        Double(marketCap ?? "") ?? 0
    }
    
    var volume24hDouble: Double {
        Double(volume24h ?? "") ?? 0
    }
    
    // MARK: - Formatting Helpers
    
    var formattedPrice: String {
        priceDouble.formatted(.currency(code: "USD"))
    }
    
    var formattedChange: String {
        String(format: "%.2f%%", changeDouble)
    }
    
    var formattedMarketCap: String {
        marketCapDouble.formatted(.number.notation(.compactName))
    }
    
    var isPositive: Bool {
        changeDouble >= 0
    }
    
    var iconColor : Color {
        switch name {
        case "APE": return Color.blue
        case "BNB": return Color.yellow
        case "BCH": return Color(hex: "00D9A3")
        case "DASH": return Color.blue
        case "DENT": return Color.gray
        case "NEO": return Color(hex: "00D9A3")
        case "SNT": return Color.blue
        default: return Color.gray
        }
    }
}
