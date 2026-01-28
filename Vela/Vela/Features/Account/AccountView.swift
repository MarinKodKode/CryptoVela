//
//  AccountView.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 27/01/26.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        
        ZStack {
            LinearGradient(colors:[ Color(hex: "031449"),
                                    Color(hex: "0F3319")], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            Text("Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
        
    }
}

#Preview {
    AccountView()
}
