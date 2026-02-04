//
//  CandlestickData.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 27/01/26.
//

import Foundation

struct CandlestickData : Identifiable {
    
    let id = UUID()
    let timestamp : Date
    let open : Double
    let close : Double
    let high : Double
    let low : Double
    
    var isPositive : Bool {
        close >= open
    }
}
