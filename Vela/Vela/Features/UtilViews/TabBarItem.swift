//
//  TabBarItem.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 14/01/26.
//

import Foundation
import SwiftUI

struct TabBarItem : View {
    
    let icon : String
    let label  : String
    let isSelected : Bool
    
    var body: some View {
        VStack (spacing : 5){
            Image(systemName: icon)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(isSelected ? .white : .white.opacity(0.5))
                .frame(width: 24, height: 24)
                .padding(8)
                .background(
                    isSelected  ?
                    LinearGradient(
                        colors: [
                            Color(hex : "8b5cf6"),
                            Color(hex : "6366f1")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ) : LinearGradient(
                        colors: [.clear],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(
                    color : isSelected ? Color(hex : "8b5cf6")
                        .opacity(0.4) : .clear,
                    radius: 10
                )
            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(isSelected ? .white : .white.opacity(0.6))
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
        .background(
            isSelected ?
            Color(hex : "a78bfa").opacity(0.2) :
                Color.purple.opacity(0.15)
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    HStack {
        TabBarItem(icon: "flame", label: "Crypp", isSelected: true)
        TabBarItem(icon: "flame.fill", label: "Crypp", isSelected: false)
    }
    
}
