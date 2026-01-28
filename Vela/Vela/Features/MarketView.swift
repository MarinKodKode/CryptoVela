//
//  MarketView.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 26/01/26.
//

import Foundation
import SwiftUI
import Charts

struct MarketView : View {
    
    @State var selectedCategory = "ALTS"
    @State var selectedCrypto = "ETH"
    
    let categories = ["FIAT", "ETF", "BNB", "BTC", "ALTS"]
    let cryptoFilters = ["ALL", "ETH", "TRX", "XRP", "DOGE"]
    
    var body: some View {
        ZStack {
            LinearGradient(colors:[ Color(hex: "031449"),
                                    Color(hex: "0F3319")], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(spacing : 0) {
                
                // Header
                HStack {
                    Circle()
                        .fill(Color(hex : "00D9A3"))
                        .frame(width: 28, height: 30)
                    
                    Text("Market")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Button(action: {}){
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.white)
                            .font(.system(size: 22))
                    }
                    
                    Button(action: {}){
                        Image(systemName: "pencil")
                            .foregroundStyle(.white)
                            .font(.system(size: 22))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 20)
                
                //Category Tabs
                ScrollView (.horizontal, showsIndicators: false){
                    HStack(spacing : 25) {
                        ForEach(categories, id: \.self){ category in
                            VStack (spacing: 8){
                                Text(category)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(
                                        selectedCategory == category
                                        ? Color(hex : "00D9A3") : Color.gray)
                                
                                if selectedCategory == category {
                                    Rectangle()
                                        .fill(Color(hex : "00D9A3"))
                                        .frame(height: 3)
                                }
                            }
                            .onTapGesture {
                                selectedCategory = category
                            }
                        }
                    }
                    
                }
                .padding(.bottom, 20 )
                .padding(.horizontal, 16)
                
//                 Crypto filter pills
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 12){
                        ForEach(cryptoFilters, id: \.self) { filter in
                            Text(filter)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(
                                    selectedCrypto == filter ? .black : Color(hex : "00D9A3"))
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                                .background(
                                    Capsule()
                                        .fill(
                                            selectedCrypto == filter ? Color(
                                                hex : "00D9A3"
                                            ) : Color.clear
                                        )
                                        .overlay(
                                            Capsule()
                                                .stroke(
                                                    Color(hex : "00D9A3"),
                                                    lineWidth: 2
                                                )
                                        )
                                )
                                .onTapGesture {
                                    selectedCrypto = filter
                                }
                        }
                    }
                }
                .padding(.bottom, 20)
                .padding(.horizontal, 16)
                

                HStack {
                    Text("Name")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.system(size: 8))
                        .foregroundStyle(.gray)
                    
                    Text("Vol")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                        .padding(.leading, 8)
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.system(size: 8))
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                    Text("Graph")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.system(size: 8))
                        .foregroundStyle(.gray)
                    
                    Text("24h Change")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                        .padding(.leading, 8)
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.system(size: 8))
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
                
                ScrollView() {
                    VStack {
                        ForEach(cryptoData){ crypto in
                            CryptoRows(crypto : crypto)
                        }
                    }
                }
            }
        }
    }
}

struct CryptoRows : View {
    
    let crypto : CryptoItem
    
    var body: some View {
        HStack(spacing : 12){
            Circle()
                .fill(crypto.iconColor.opacity(0.8))
                .frame(width: 44, height: 44)
                .overlay(
                    Text(String(crypto.name.prefix(1)))
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                )
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4){
                Text("\(crypto.name) / \(crypto.pair)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.85))
                Text("Vol \(crypto.volume)")
                    .font(.system(size: 12))
                    .foregroundStyle(.white.opacity(0.6))
            }
            
            Spacer()
            
            ChartView(isPositive: crypto.isPositive)
                .frame(width: 80, height: 30)
            
            Spacer()
            VStack(alignment: .trailing, spacing: 4){
                Text(crypto.price)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.8))
                
                Text(String(format: "%+.2f%%", crypto.change))
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(crypto.isPositive ? Color(hex: "00D9A3") : Color(hex: "FF4D4D"))
            }
        }
        .padding(.horizontal, 16)
    }
}


struct ChartView : View {
    
    let isPositive :  Bool
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let points: [CGFloat] = isPositive ?
                [0.7, 0.5, 0.6, 0.4, 0.3, 0.4, 0.2, 0.1,0.4, 0.2, 0.1,0.3, 0.2, 0.1,0.4, 0.2, 0.1,0.5, 0.2, 0.1,0.9, 0.23, 0.1] :
                                    [0.3, 0.5, 0.4, 0.6, 0.7, 0.6, 0.8, 0.9,0.4, 0.2, 0.1,0.4, 0.2, 0.1,0.4, 0.2, 0.1,0.4, 0.2, 0.1,0.4, 0.2, 0.1]
                
                let width = geometry.size.width
                let height = geometry.size.height
                let step = width / CGFloat(points.count - 1)
                
                path.move(to: CGPoint(x : 0, y : height * points[0]))
                
                for i in 1..<points.count {
                    path.addLine(to: CGPoint(x: step * CGFloat(i), y: height * points[i]))
                }
            }
            .stroke(isPositive ? Color(hex: "00D9A3") : Color(hex: "FF4D4D"), lineWidth: 2)
        }
    }
}


#Preview {
    MarketView()
}
