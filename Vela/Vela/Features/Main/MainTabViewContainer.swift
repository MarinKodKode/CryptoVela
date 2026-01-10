//
//  MainTabViewContainer.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 09/01/26.
//

import Foundation
import SwiftUI

struct MainTabViewContainer : View {
    
    @State private var selectedTab = 0
    @State private var showSearch = false
    @State private var searchText = ""
    
    var body : some View {
        
        ZStack {
            AnimatedGradientBackground() 
        }
        
    }
        
}
