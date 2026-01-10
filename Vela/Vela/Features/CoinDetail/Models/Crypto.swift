//
//  Cryoto.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 08/01/26.
//

import Foundation
import SwiftUI

struct Crypto : Identifiable {
    let id = UUID()
    let name : String
    let symbol : String
    let price : Double
    let change24h : Double
    let volume : String 
    let marketCap : String
    let chartData : [Double]
    let icon : String
    let gradient : [Color]
}
