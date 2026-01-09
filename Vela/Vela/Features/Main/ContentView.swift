//
//  ContentView.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 08/01/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

// Ejemplo rápido de la celda del Dashboard
struct CryptoRow: View {
    let coin: CryptoModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: coin.image))
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                Text(coin.name).font(.headline)
                Text(coin.symbol.uppercased()).font(.caption).foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("$\(coin.currentPrice, specifier: "%.2f")")
                    .bold()
                Text("\(coin.priceChangePercentage24H, specifier: "%.2f")%")
                    .foregroundColor(coin.priceChangePercentage24H >= 0 ? .green : .red)
            }
        }
    }
}

#Preview {
    ContentView()
}
