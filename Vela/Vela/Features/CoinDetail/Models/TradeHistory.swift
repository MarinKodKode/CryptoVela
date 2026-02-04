//
//  TradeHistory.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 27/01/26.
//

import Foundation

struct TradeHistory : Identifiable {
    
    let id = UUID()
    let time : String
    let price : String
    let quantity : String
    
}

