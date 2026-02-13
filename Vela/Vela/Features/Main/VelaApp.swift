//
//  VelaApp.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 08/01/26.
//

import SwiftUI

@main
struct VelaApp: App {
    
    @StateObject private var navigationRouter = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationRouter)
        }
    }
}
