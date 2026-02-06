import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var navigationRouter : NavigationRouter
    
    var body: some View {
        
        NavigationStack(path: $navigationRouter.path){
            Group {
                ContentMainView()
            }
            .navigationDestination(for: AppRoute.self){ route in
                switch route {
                case .crypto_detail(let crypto) :
                    TradingView()
                        .environmentObject(navigationRouter)
                case .market :
                    MarketView()
                        .environmentObject(navigationRouter)
                }
            }
        }
    }
    
}
