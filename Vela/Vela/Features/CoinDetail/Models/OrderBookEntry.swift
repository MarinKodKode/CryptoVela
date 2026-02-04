//
//  OrderBookEntry.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 27/01/26.
//

import Foundation

struct OrderBookEntry : Identifiable {
    
    let id = UUID()
    let quantity : String
    let price : String
    let side : OrderSide
    
    enum OrderSide {
        case bid, ask
    }
}
