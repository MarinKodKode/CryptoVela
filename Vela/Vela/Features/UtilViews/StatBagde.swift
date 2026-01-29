//
//  StatBagde.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 14/01/26.
//

import Foundation
import SwiftUI

struct StatBagde : View {
    
    let label : String
    let value  : String
    
    var body: some View {
        VStack (spacing: 4){
            Text(label)
                .font(.system(size: 10))
                .foregroundColor(.white.opacity(0.5))
            Text(value)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8 )
        .background(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
}

#Preview {
    StatBagde(label: "crypto", value: "22")
}
