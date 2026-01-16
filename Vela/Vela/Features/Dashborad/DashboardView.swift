import Foundation
import SwiftUI

struct DashboardView : View {
    
    @Binding var showSearch : Bool
    @Binding var searchText : String
   
//    var filteredCryptos : [Crypto] {
//        if searchText.isEmpty {
//            return cryptos
//        }
//        return cryptos.filter {
//            $0.name.localizedCaseInsensitiveContains(searchText) ||
//            $0.symbol.localizedCaseInsensitiveContains(searchText)
//        }
//    }

    var filteredCryptos : [Crypto] = cryptos
    
    var body : some View {
        ScrollView {
            VStack (spacing : 0){
                HStack {
                    Text("Dashboard")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.white, Color(hex : "a78bfa")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    Spacer()
                    Button {
                        withAnimation(.spring(response : 0.3)){
                            showSearch = true
                        }
                    }label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.white.opacity(0.2), lineWidth: 1)
                            )
                    }
                    Button {} label: {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.white.opacity(0.2), lineWidth: 1)
                            )
                    }
                    
                }
                
                LazyVStack(spacing : 15){
                    ForEach(filteredCryptos){ crypto in
                        CryptoCard(crypto: crypto)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100 )
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
