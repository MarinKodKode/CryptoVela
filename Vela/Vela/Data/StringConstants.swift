import Foundation
import SwiftUI
let cryptos = [
    Crypto(name: "Bitcoin", symbol: "BTC", price: 43250.00, change24h: 5.4,
           volume: "$28.5B", marketCap: "$845B",
           chartData: [0.6, 0.75, 0.55, 0.85, 0.7, 0.9, 1.0],
           icon: "₿", gradient: [Color(hex: "8b5cf6"), Color(hex: "6366f1")]),
    
    Crypto(name: "Ethereum", symbol: "ETH", price: 2287.50, change24h: 3.2,
           volume: "$15.2B", marketCap: "$275B",
           chartData: [0.7, 0.65, 0.8, 0.75, 0.85, 0.9, 0.95],
           icon: "Ξ", gradient: [Color(hex: "627eea"), Color(hex: "4c6ef5")]),
    
    Crypto(name: "Tether", symbol: "USDT", price: 1.00, change24h: -0.02,
           volume: "$42.8B", marketCap: "$95.2B",
           chartData: [0.5, 0.52, 0.48, 0.51, 0.49, 0.5, 0.48],
           icon: "₮", gradient: [Color(hex: "26a17b"), Color(hex: "2ecc71")]),
    
    Crypto(name: "Solana", symbol: "SOL", price: 98.45, change24h: 8.7,
           volume: "$3.2B", marketCap: "$42.8B",
           chartData: [0.5, 0.6, 0.7, 0.65, 0.8, 0.85, 1.0],
           icon: "◎", gradient: [Color(hex: "9945FF"), Color(hex: "14F195")])
]
