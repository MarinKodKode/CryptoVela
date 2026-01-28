//
//  PricePoint.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 27/01/26.
//

import Foundation

struct PricePoint  : Identifiable {
    
    let id = UUID()
    let timestamp : Date
    let price : Double
    
}
