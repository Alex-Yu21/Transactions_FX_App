final class TransactionRepository {
    private let resourceLoader: PlistResourceLoader

    init(resourceLoader: PlistResourceLoader = PlistResourceLoader()) {
        self.resourceLoader = resourceLoader
    }
}

// TransactionRepositoryProtocol
extension TransactionRepository: TransactionRepositoryProtocol {
    func fetchTransactions() -> [Transaction] {
        let transactions: [TransactionDTO] = resourceLoader.load(Constants.transactionsResource)
        return transactions.map { $0.toDomain() }
    }

    func fetchRates() -> [Rate] {
        let rates: [RateDTO] = resourceLoader.load(Constants.ratesResource)
        return rates.map { $0.toDomain() }
    }
}

// Constants
private extension TransactionRepository {
    enum Constants {
        static let transactionsResource = "transactions"
        static let ratesResource = "rates"
    }
}
