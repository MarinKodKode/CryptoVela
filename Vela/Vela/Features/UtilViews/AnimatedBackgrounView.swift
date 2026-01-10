//
//  AnimatedBackgrounView.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 09/01/26.
//

import Foundation
import SwiftUI

struct AnimatedGradientBackground : View  {
    
    @State private var animate = false
    
    var body : some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(hex : "0a0e27"),
                    Color(hex : "1a1f3a"),
                    Color(hex : "2d1b4e"),
                    Color(hex : "1a1f3a"),
                    Color(hex : "0a0e27")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color(hex : "8b5cf6").opacity(0.3), .clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 100
                    )
                )
                .frame(width: 200, height: 200)
                .blur(radius: 60)
                .offset(x: animate ? 30 : -30, y: animate ? -30 : 30 )
                .position(x : UIScreen.main.bounds.width * 0.8, y : 100 )
                .animation(
                    .easeInOut(duration: 10)
                    .repeatForever(autoreverses: true),
                    value: animate
                )
            
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(hex: "")
                        ],
                        center: <#T##UnitPoint#>,
                        startRadius: <#T##CGFloat#>,
                        endRadius: <#T##CGFloat#>
                    )
                )
        }
    }
}
//
//#Preview {
//    AnimatedGradientBackground(animate: false)
//}
