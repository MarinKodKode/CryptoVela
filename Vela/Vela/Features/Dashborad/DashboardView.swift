import Foundation
import SwiftUI
struct DashboardView : View {
    @Binding var showSearch : Bool
    @Binding var searchText : String
    var filteredCryptos : [Crypto] = cryptos
    var body : some View {
        ZStack {
            
            LinearGradient(colors: [
                Color.yellow.opacity(0.7),
                Color.indigo
            ],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            ScrollView (showsIndicators: false){
                VStack (spacing : 0){
                    LazyVStack(spacing : 15){
                        ForEach(filteredCryptos) { crypto in
                            CryptoCard(crypto: crypto)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 100 )
                }
            }

        }
    }
}
#Preview {
    DashboardView(
        showSearch: .constant(false),
        searchText: .constant("Texto prueba")
    )
}
