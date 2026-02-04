//
//  CryptoItem.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 26/01/26.
//

import Foundation
import SwiftUI

struct CryptoItem : Identifiable {
    let id = UUID()
    let name : String
    let pair : String
    let price : String
    let volume : String
    let change : Double
    let isPositive : Bool
    
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
