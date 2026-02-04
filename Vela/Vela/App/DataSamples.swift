//
//  DataSamples.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 26/01/26.
//

import Foundation

let cryptoData: [CryptoItem] = [
        CryptoItem(name: "APE", pair: "ETH", price: "$4.09", volume: "$267,239,362", change: -2.64, isPositive: false),
        CryptoItem(name: "BNB", pair: "ETH", price: "$267.33", volume: "$1,189,151,009", change: 0.96, isPositive: true),
        CryptoItem(name: "BCH", pair: "ETH", price: "$105.26", volume: "$118,014,166", change: 2.95, isPositive: true),
        CryptoItem(name: "DASH", pair: "ETH", price: "$48.32", volume: "$106,876,921", change: -1.68, isPositive: false),
        CryptoItem(name: "DENT", pair: "ETH", price: "$0.0046", volume: "$5,71938", change: 1.65, isPositive: true),
        CryptoItem(name: "NEO", pair: "ETH", price: "$7.35", volume: "$71,993,161", change: -1.92, isPositive: false),
        CryptoItem(name: "SNT", pair: "ETH", price: "$0.0037", volume: "$43,7178", change: 2.23, isPositive: true)
    ]


//Sample Data
let currentPrice = 17185.06
    let priceChange = 0.45
    let priceChangeAmount = 17184.25
    let highPrice = 17295.46
    let lowPrice = 16956.25
    let volume = 17584770.447
    
    let pricePoints: [PricePoint] = {
        let basePrice = 17100.0
        return (0..<50).map { i in
            let randomOffset = Double.random(in: -200...200)
            return PricePoint(
                timestamp: Date().addingTimeInterval(Double(i * 600)),
                price: basePrice + randomOffset
            )
        }
    }()

let candlestickData: [CandlestickData] = {
        let basePrice = 17100.0
        return (0..<15).map { i in
            let open = basePrice + Double.random(in: -150...150)
            let close = open + Double.random(in: -200...200)
            let high = max(open, close) + Double.random(in: 0...100)
            let low = min(open, close) - Double.random(in: 0...100)
            return CandlestickData(
                timestamp: Date().addingTimeInterval(Double(i * 3600)),
                open: open,
                close: close,
                high: high,
                low: low
            )
        }
    }()
    
    let tradeHistory: [TradeHistory] = [
        TradeHistory(time: "15:48:56", price: "17,184.99", quantity: "1.041"),
        TradeHistory(time: "15:48:53", price: "17,184.87", quantity: "1.096"),
        TradeHistory(time: "15:48:49", price: "17,184.74", quantity: "1.009")
    ]
    
    let orderBook: [OrderBookEntry] = [
        OrderBookEntry(quantity: "2.003", price: "17,184.99", side: .bid),
        OrderBookEntry(quantity: "1.021", price: "17,184.85", side: .bid),
        OrderBookEntry(quantity: "2.002", price: "17,184.82", side: .bid),
        OrderBookEntry(quantity: "2.002", price: "17,184.22", side: .ask),
        OrderBookEntry(quantity: "1.047", price: "17,184.27", side: .ask),
        OrderBookEntry(quantity: "1.026", price: "17,184.08", side: .ask)
    ]
