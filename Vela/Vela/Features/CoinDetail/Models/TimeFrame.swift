//
//  TimeFrame.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 27/01/26.
//


import Foundation

enum TimeFrame : String, CaseIterable {
    
    case oneDay = "1D"
    case oneWeek = "1W"
    case oneMonth = "1M"
    case oneYear = "3M"
    case threeMonths = "1Y"
    case allTime = "All Time"
    
}


enum ViewTabs {
    
    case orders
    case history 
    
}
