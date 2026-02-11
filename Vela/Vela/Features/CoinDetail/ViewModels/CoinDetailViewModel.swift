import Foundation
internal import Combine

@MainActor
final class CryptoDetailViewModel: ObservableObject {

    @Published var coin: Coin?
    @Published var historyData: [HistoryPoint] = []
    @Published var isLoading = false
    @Published var isLoadingHistory = false
    @Published var selectedInterval: HistoryInterval = .h1
    @Published var errorMessage: String?

    private let coinId: String
    private let cryptoService: CryptoServiceProtocol

    init(
        coinId: String,
        cryptoService: CryptoServiceProtocol = CryptoService()
    ) {
        self.coinId = coinId
        self.cryptoService = cryptoService
    }

    func loadAssetDetails() async {
        isLoading = true
        errorMessage = nil

        do {
            coin = try await cryptoService.fetchCoin(by: coinId)
            await loadHistory(for: selectedInterval)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func refresh() async {
        await loadAssetDetails()
    }

    func loadHistory(for interval: HistoryInterval) async {
        selectedInterval = interval
        isLoadingHistory = true

        do {
            historyData = try await cryptoService.fetchHistory(
                coinUUID: coinId,
                interval: .d30
            )
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoadingHistory = false
    }
}
