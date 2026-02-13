//
//  NavigationRouter.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 05/02/26.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
final class NavigationRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func push(_ route : AppRoute){
        path.append(route)
    }
    
    func goTo(_ route : AppRoute){
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func goBack(){
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func setRoot(to route: AppRoute) {
        path = NavigationPath()
        path.append(route)
    }
}
