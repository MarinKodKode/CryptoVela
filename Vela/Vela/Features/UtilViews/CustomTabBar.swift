//
//  CustomTabBar.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 14/01/26.
//

import Foundation
import SwiftUI

struct CustomTabBar : View {
    
    @Binding var selectedTab : Int
    
    var body : some View {
        HStack(spacing: 30){
            TabBarItem(
                icon: "chart.line.uptrend.xyaxis",
                label: "Popular",
                isSelected: selectedTab == 0 )
            .onTapGesture {
                withAnimation{ selectedTab = 0 }
            }
            
            TabBarItem(
                icon: "star.fill",
                label: "Guardados",
                isSelected: selectedTab == 1
            )
            .onTapGesture {
                withAnimation{ selectedTab = 1}
            }
            
            TabBarItem(
                icon: "book.fill",
                label: "Aprende",
                isSelected: selectedTab == 2
            )
            .onTapGesture {
                withAnimation{ selectedTab = 2 }
            }
        }
        .padding(.horizontal, 20 )
        .padding(.vertical , 12)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(.white.opacity(0.2), lineWidth: 1)
        )
        .shadow(color : .black.opacity(0.3), radius: 15)
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(0))
}
