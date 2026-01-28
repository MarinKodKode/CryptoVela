//
//  TradingView.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 27/01/26.
//

import Foundation
import SwiftUI
import Charts

struct TradingView : View {
    
    @State private var selectedCharType : ChartType = .line
    @State private var selectedTimeFrame : TimeFrame = .oneDay
    @State private var selectedTab : ViewTabs = .history
    
    var body: some View {
        ZStack {
            
            Color(red : 0.11, green: 0.12, blue : 0.15)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                headerView
                
                priceInfoView
                
                chartView
                    .frame(height: 280)
                    .padding(.horizontal)
                
                timeframeSelector
                
                tabSelector
                
                historyView
                
                ordersView
                
                actionButtons
            }
            
        }
    }
    
    var headerView : some View {
        HStack {
            Button(action : {}){
                Image(systemName: "chevron.left")
                    .foregroundStyle(.white)
                    .font(.title2)
            }
            
            Text("BTC/USDT")
                .font(.system(size : 20, weight: .semibold))
                .foregroundStyle(.white)
            
            Spacer()
            
            Button(action: {}){
                Image(systemName: "star.fill")
                    .foregroundStyle(.white)
            }
            
            Button(action : {}){
                Image(systemName: "paperplane")
                    .foregroundStyle(.white)
            }
            
            Button(action : {}){
                Image(systemName: "ellipsis")
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
            }
        }
        .padding()
        
    }
    
    var priceInfoView : some View {
        HStack (alignment: .top){
            VStack(alignment: .leading, spacing : 4){
                Text(String(format: "%.2f", currentPrice))
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(.white)
                
                HStack(spacing: 4){
                    Text(String(format: "%2f", priceChangeAmount))
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.white.opacity(0.6))
                    Text(String(format: "(+ %.2f%%)", priceChange))
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.0, green: 0.8, blue: 0.6))
                }
                
                Spacer()
                
                VStack (alignment: .trailing, spacing : 8){
                    HStack {
                        Text("24h vol")
                            .font(.system(size: 12))
                            .foregroundStyle(Color(red: 0.5, green: 0.55, blue: 0.6))
                        Text(String(format: "$%.0f", volume))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white)
                    }
                    
                    HStack {
                        Text("High Price")
                            .font(.system(size: 12))
                            .foregroundStyle(Color(red: 0.5, green: 0.55, blue: 0.6))
                        Text(String(format: "$%.2f", highPrice))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white)
                    }
                    
                    HStack {
                        Text("Low Price")
                            .font(.system(size: 12))
                            .foregroundStyle(Color(red: 0.5, green: 0.55, blue: 0.6))
                        Text(String(format: "$%.2f", lowPrice))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white)
                    }
                }
                
            }
        }
        .padding(.horizontal)
    }
    
    var chartView : some View {
        VStack {
            if selectedCharType == .line {
                lineChartView
            }else {
                candlestickChartView
            }
        }
    }
    
    var lineChartView : some View {
        Chart {
            ForEach(pricePoints) { point in
                LineMark(
                    x : .value("Time", point.timestamp),
                    y : .value("Price", point.price)
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(red: 0.0, green: 0.8, blue: 0.6)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .lineStyle(StrokeStyle(lineWidth: 2))
                
                AreaMark(
                    x: .value("Time", point.timestamp),
                    y: .value("Price", point.price)
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(red: 0.0, green: 0.8, blue: 0.6).opacity(0.3),
                            Color(red: 0.0, green: 0.8, blue: 0.6).opacity(0.0)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis {
            AxisMarks(position : .trailing) { value in
                AxisValueLabel {
                    if let price = value.as(Double.self) {
                        Text(String(format: "$%.0f", price))
                            .font(.system(size: 10))
                            .foregroundColor(Color(red: 0.5, green: 0.55, blue: 0.6))
                    }
                }
            }
        }
        .chartYScale(domain: lowPrice...highPrice)
    }
    
    var candlestickChartView : some View {
        Chart {
            ForEach(candlestickData) { candle in
                RectangleMark(
                    x : .value("Time", candle.timestamp),
                    yStart: .value("Low", candle.low),
                    yEnd: .value("High", candle.high),
                    width: 2
                )
                
                RectangleMark(
                    x : .value("Time", candle.timestamp),
                    yStart: .value("Open", candle.open),
                    yEnd: .value("Close", candle.close),
                    width: 20
                )
                .foregroundStyle(
                    candle.isPositive ?
                    Color(red: 0.0, green: 0.8, blue: 0.6) :
                    Color(red: 0.5, green: 0.55, blue: 0.6)
                )
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis {
            AxisMarks(position: .trailing) { value in
                AxisValueLabel {
                    if let price = value.as(Double.self) {
                        Text(String(format: "$%.0f", price))
                            .font(.system(size: 10))
                            .foregroundColor(Color(red: 0.5, green: 0.55, blue: 0.6))
                    }
                }
            }
        }
        .chartYScale(domain: lowPrice...highPrice)
    }
    
    var timeframeSelector : some View  {
        HStack {
            ForEach(TimeFrame.allCases, id : \.self) { timeframe in
                Button(action : {}) {
                    Text(timeframe.rawValue)
                        .font(.system(size: 13, weight: selectedTimeFrame == timeframe ? .semibold : .regular))
                        .foregroundColor(selectedTimeFrame == timeframe ?
                                         Color(red: 0.0, green: 0.8, blue: 0.6) :
                                            Color(red: 0.5, green: 0.55, blue: 0.6))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            selectedTimeFrame == timeframe ?
                            Color(red: 0.0, green: 0.8, blue: 0.6).opacity(0.1) :
                                Color.clear
                        )
                        .cornerRadius(6)
                }
            }
        }
        .padding(.horizontal)
    }
    
    var tabSelector: some View {
            HStack(spacing: 40) {
                Button(action: { selectedTab = .orders }) {
                    VStack(spacing: 4) {
                        Text("Orders")
                            .font(.system(size: 16, weight: selectedTab == .orders ? .semibold : .regular))
                            .foregroundColor(selectedTab == .orders ?
                                Color(red: 0.0, green: 0.8, blue: 0.6) :
                                Color(red: 0.5, green: 0.55, blue: 0.6))
                        
                        if selectedTab == .orders {
                            Rectangle()
                                .fill(Color(red: 0.0, green: 0.8, blue: 0.6))
                                .frame(height: 2)
                        }
                    }
                }
                
                Button(action: { selectedTab = .history }) {
                    VStack(spacing: 4) {
                        Text("History")
                            .font(.system(size: 16, weight: selectedTab == .history ? .semibold : .regular))
                            .foregroundColor(selectedTab == .history ?
                                Color(red: 0.0, green: 0.8, blue: 0.6) :
                                Color(red: 0.5, green: 0.55, blue: 0.6))
                        
                        if selectedTab == .history {
                            Rectangle()
                                .fill(Color(red: 0.0, green: 0.8, blue: 0.6))
                                .frame(height: 2)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
    
    var historyView: some View {
            VStack(spacing: 0) {
                HStack {
                    Text("Time")
                        .font(.system(size: 13))
                        .foregroundColor(Color(red: 0.5, green: 0.55, blue: 0.6))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Price")
                        .font(.system(size: 13))
                        .foregroundColor(Color(red: 0.5, green: 0.55, blue: 0.6))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("Quantity")
                        .font(.system(size: 13))
                        .foregroundColor(Color(red: 0.5, green: 0.55, blue: 0.6))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
                
                ForEach(tradeHistory) { trade in
                    HStack {
                        Text(trade.time)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(trade.price)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color(red: 0.0, green: 0.8, blue: 0.6))
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text(trade.quantity)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                }
            }
        }
    
    var ordersView: some View {
            VStack(spacing: 0) {
                HStack {
                    Text("Bid")
                        .font(.system(size: 13))
                        .foregroundColor(Color(red: 0.5, green: 0.55, blue: 0.6))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Text("Ask")
                        .font(.system(size: 13))
                        .foregroundColor(Color(red: 0.5, green: 0.55, blue: 0.6))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
                
                ForEach(orderBook) { order in
                    HStack {
                        if order.side == .bid {
                            Text(order.quantity)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(order.price)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color(red: 0.0, green: 0.8, blue: 0.6))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                        } else {
                            Spacer()
                            
                            Text(order.price)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.3))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                            Text(order.quantity)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                }
            }
        }
    
    var actionButtons: some View {
            HStack(spacing: 12) {
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .frame(width: 50, height: 50)
                        .background(Color(red: 0.2, green: 0.21, blue: 0.25))
                        .clipShape(Circle())
                }
                
                Button(action: {}) {
                    Text("Sell")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(red: 0.2, green: 0.21, blue: 0.25))
                        .cornerRadius(25)
                }
                
                Button(action: {}) {
                    Image(systemName: "heart")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .frame(width: 50, height: 50)
                        .background(Color(red: 0.2, green: 0.21, blue: 0.25))
                        .clipShape(Circle())
                }
                
                Button(action: {}) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .frame(width: 50, height: 50)
                        .background(Color(red: 0.2, green: 0.21, blue: 0.25))
                        .clipShape(Circle())
                }
                
                Button(action: {}) {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .frame(width: 50, height: 50)
                        .background(Color(red: 0.2, green: 0.21, blue: 0.25))
                        .clipShape(Circle())
                }
                
                Button(action: {}) {
                    Text("Buy")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(red: 0.0, green: 0.8, blue: 0.6))
                        .cornerRadius(25)
                }
                
                Button(action: {}) {
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .frame(width: 50, height: 50)
                        .background(Color(red: 0.2, green: 0.21, blue: 0.25))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)
        }
}


#Preview {
    TradingView()
}
