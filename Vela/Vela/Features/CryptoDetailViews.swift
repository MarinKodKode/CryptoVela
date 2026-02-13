//import SwiftUI
//import Charts
//
//struct CryptoDetailView: View {
//
//    let coinId: String
//
//    @StateObject private var viewModel: CryptoDetailViewModel
//    @EnvironmentObject private var favoritesManager: FavoritesManager
//
//    init(coinId: String) {
//        self.coinId = coinId
//        _viewModel = StateObject(
//            wrappedValue: CryptoDetailViewModel(coinId: coinId)
//        )
//    }
//
//    var body: some View {
//        ScrollView {
//            if viewModel.isLoading {
//                ProgressView()
//                    .padding(.top, 100)
//            } else if let coin = viewModel.coin {
//                VStack(spacing: 24) {
//                    headerSection(coin: coin)
//                    priceChartSection
//                    statsSection(coin: coin)
//                }
//                .padding()
//            }
//        }
//        .navigationTitle(viewModel.coin?.symbol ?? "")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            if let coin = viewModel.coin {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    favoriteButton(for: coin)
//                }
//            }
//        }
//        .task {
//            await viewModel.loadAssetDetails()
//        }
//        .refreshable {
//            await viewModel.refresh()
//        }
//    }
//
//    // MARK: - Header
//
//    private func headerSection(coin: Coin) -> some View {
//        VStack(spacing: 12) {
//            Text(coin.name)
//                .font(.title2)
//                .fontWeight(.bold)
//
//            Text(coin.formattedPrice)
//                .font(.system(size: 48, weight: .bold))
//
//            HStack(spacing: 8) {
//                Image(systemName: coin.isPositiveChange ? "arrow.up.right" : "arrow.down.right")
//                Text(coin.formattedChange)
//            }
//            .foregroundStyle(coin.isPositiveChange ? .green : .red)
//        }
//    }
//
//    // MARK: - Chart
//
//    private var priceChartSection: some View {
//        VStack(alignment: .leading) {
//            Text("Price Chart")
//                .font(.headline)
//
//            if viewModel.isLoadingHistory {
//                ProgressView()
//                    .frame(height: 200)
//            } else {
//                Chart(viewModel.historyData) {
//                    LineMark(
//                        x: .value("Time", $0.timestamp),
//                        y: .value("Price", $0.price)
//                    )
//                }
//                .frame(height: 200)
//            }
//
//            intervalPicker
//        }
//    }
//
//    private var intervalPicker: some View {
//        HStack {
//            ForEach(HistoryInterval.allCases, id: \.self) {
//                Button($0.rawValue) {
//                    Task {
//                        await viewModel.loadHistory(for: $0)
//                    }
//                }
//            }
//        }
//    }
//
//    // MARK: - Stats
//
//    private func statsSection(coin: Coin) -> some View {
//        VStack {
//            statRow("Market Cap", coin.formattedMarketCap)
//            statRow("24h Volume", coin.formattedVolume)
//            statRow("Rank", "#\(coin.rank)")
//
//            if let supply = coin.supply?.circulating {
//                statRow("Circulating Supply", supply)
//            }
//        }
//    }
//
//    private func statRow(_ title: String, _ value: String) -> some View {
//        HStack {
//            Text(title)
//            Spacer()
//            Text(value).bold()
//        }
//    }
//
//    // MARK: - Favorites
//
//    private func favoriteButton(for coin: Coin) -> some View {
//        Button {
//            favoritesManager.toggleFavorite(coin.uuid)
//        } label: {
//            Image(
//                systemName: favoritesManager.isFavorite(coin.uuid)
//                ? "star.fill"
//                : "star"
//            )
//        }
//    }
//}
