import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            DashboardView(
                showSearch: .constant(false),
                searchText: .constant("Text")
            )
        }
        .padding()
    }
}


struct CryptoRow: View {
    let coin: Crypto
    var body: some View {
        HStack {
//            AsyncImage(url: URL(string: coin.image))
//                .frame(width: 30, height: 30)
//            VStack(alignment: .leading) {
//                Text(coin.name).font(.headline)
//                Text(coin.symbol.uppercased()).font(.caption).foregroundColor(.gray)
//            }
//            Spacer()
//            VStack(alignment: .trailing) {
//                Text("$\(coin.currentPrice, specifier: "%.2f")")
//                    .bold()
//                Text("\(coin.priceChangePercentage24H, specifier: "%.2f")%")
//                    .foregroundColor(coin.priceChangePercentage24H >= 0 ? .green : .red)
//            }
        }
    }
}

#Preview {
    ContentView()
}
