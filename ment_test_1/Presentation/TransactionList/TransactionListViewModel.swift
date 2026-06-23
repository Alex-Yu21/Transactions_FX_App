import Foundation

final class TransactionListViewModel {
    private let repository: TransactionRepositoryProtocol
    private let skuListAggregator: SKUListAggregator
    private var groups: [ProductGroup] = []
    private var rates: [Rate] = []

    init(repository: TransactionRepositoryProtocol = TransactionRepository(),
         skuListAggregator: SKUListAggregator = SKUListAggregator()) {
        self.repository = repository
        self.skuListAggregator = skuListAggregator
    }
}

// TransactionListViewModeling
extension TransactionListViewModel: TransactionListViewModeling {
    var productCount: Int {
        groups.count
    }

    func loadProducts(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            let transactions = self.repository.fetchTransactions()
            let loadedRates = self.repository.fetchRates()
            let loadedGroups = self.skuListAggregator.aggregate(transactions)
            DispatchQueue.main.async {
                self.rates = loadedRates
                self.groups = loadedGroups
                completion()
            }
        }
    }

    func item(at index: Int) -> ProductListItem {
        let group = groups[index]
        return ProductListItem(sku: group.sku, transactionCountText: transactionCountText(for: group.transactions.count))
    }

    func makeDetailViewModel(at index: Int) -> TransactionDetailViewModeling {
        let group = groups[index]
        return TransactionDetailViewModel(sku: group.sku, transactions: group.transactions, rates: rates)
    }
}

// Private Methods
private extension TransactionListViewModel {
    func transactionCountText(for count: Int) -> String {
        let format = count == 1
            ? NSLocalizedString("%d transaction", comment: "Singular transaction count")
            : NSLocalizedString("%d transactions", comment: "Plural transaction count")
        return String(format: format, count)
    }
}
