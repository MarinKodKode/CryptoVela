//
//  DashBoardViews.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 10/02/26.
//

import SwiftUI


struct DashboardViews: View {
    @StateObject private var viewModel = DashboardViewModel()
    @EnvironmentObject private var favoritesManager: FavoritesManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading && viewModel.assets.isEmpty {
                    ProgressView("Loading cryptos...")
                } else {
                    cryptoList
                }
            }
            .navigationTitle("Crypto Market")
            .searchable(text: $viewModel.searchText, prompt: "Search crypto")
            .refreshable {
                await viewModel.refreshAssets()
            }
            .task {
                if viewModel.assets.isEmpty {
                    await viewModel.loadAssets()
                }
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") {
                    viewModel.clearError()
                }
            } message: {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
    }
    
    private var cryptoList: some View {
        List {
            ForEach(viewModel.filteredAssets) { asset in
                NavigationLink(destination: CryptoDetailView(assetId: asset.id)) {
                    CryptoRowView(
                        asset: asset,
                        isFavorite: favoritesManager.isFavorite(asset.id)
                    )
                }
            }
        }
        .listStyle(.plain)
    }
}

// MARK: - Crypto Row View≈
struct CryptoRowView: View {
    let asset: Asset
    let isFavorite: Bool
    @EnvironmentObject private var favoritesManager: FavoritesManager
    
    var body: some View {
        HStack(spacing: 12) {
            // Rank
            Text("#\(asset.rank)")
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 35, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(asset.symbol)
                        .font(.headline)
                    
                    if isFavorite {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundStyle(.yellow)
                    }
                }
                
                Text(asset.name)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(asset.formattedPrice)
                    .font(.headline)
                
                Text(asset.formattedChange)
                    .font(.caption)
                    .foregroundStyle(asset.isPositiveChange ? .green : .red)
            }
        }
        .padding(.vertical, 4)
        .swipeActions(edge: .trailing) {
            Button {
                favoritesManager.toggleFavorite(asset.id)
            } label: {
                Label(
                    isFavorite ? "Remove" : "Favorite",
                    systemImage: isFavorite ? "star.slash" : "star"
                )
            }
            .tint(isFavorite ? .gray : .yellow)
        }
    }
}

#Preview {
    DashboardViews()
        .environmentObject(FavoritesManager.shared)
}
