import SwiftUI
import Charts

struct CryptoCard: View {
    
    struct StockPoint: Identifiable {
        let id = UUID()
        let time: Int
        let value: Double
    }
    
    let stockData: [StockPoint] = [
        .init(time: 1, value: 120),
        .init(time: 2, value: 195),
        .init(time: 3, value: 423),
        .init(time: 4, value: 1350),
        .init(time: 5, value: 1248),
        .init(time: 6, value: 7145),
        .init(time: 7, value: 8120),
        .init(time: 8, value: 11195),
        .init(time: 9, value: 14423),
        .init(time: 10, value: 21350),
        .init(time: 11, value: 21248),
        .init(time: 12, value: 22145)
    ]
    
    let crypto : Crypto
    
    @State private var isPressed : Bool = false
    
    var body: some View {
        
        ZStack {
                VStack {
                    HStack {
                        HStack {
                            Image("bitcoin_logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)

                            VStack(alignment: .leading) {
                                Text("Bitcoin")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                Text("BTC")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding(.horizontal, 24)

                        Spacer()
                        
                    }

                    HStack {
                        VStack(alignment: .leading) {
                            Text("$94,726.50")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            HStack {
                                Text("0.33 %")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                Image(systemName: "arrow.up")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding(.horizontal, 24)

                        Spacer()
                    }
                    
                }
                
            
                HStack {
                    VStack {
                        
                    }
                    Spacer()
                    
                    Chart(stockData) {
                        LineMark(
                            x: .value("Time", $0.time),
                            y: .value("Value", $0.value)
                        )
                        .foregroundStyle(.blue)
                        .lineStyle(StrokeStyle(lineWidth: 2))

                        AreaMark(
                            x: .value("Time", $0.time),
                            y: .value("Value", $0.value)
                        )
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    .blue.opacity(0.3),
                                    .blue.opacity(0.05)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    }
                    .chartXAxis(.hidden)
                    .chartYAxis(.hidden)
                    .chartPlotStyle { plot in
                        plot
                            .background(.clear)
                    }
                    .frame(width: 150, height: 80)
                }
                .zIndex(10)
        }
        .frame(width: 360, height: 180)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.20, green: 0.28, blue: 0.38),
                            Color(red: 0.10, green: 0.14, blue: 0.20)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
  
    }
        
}

#Preview {
    
    let crypto : Crypto = Crypto(
        name: "Bitcoin",
        symbol: "flame",
        price: 123.4,
        change24h: 12.3,
        volume: "678",
        marketCap: "5699",
        chartData: [2.3,4.5,6.4,7.6],
        icon: "flame",
        gradient: [Color(hex : "10b981"), Color(hex: "a78bfa")]
    )
    
    CryptoCard(crypto: crypto)
}
