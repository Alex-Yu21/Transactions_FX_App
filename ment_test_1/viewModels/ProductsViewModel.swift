//
//  Copyright © 2026 ment_test_1. All rights reserved.
//

final class ProductsViewModel {

    // MARK: - Public Properties

    var productCount: Int {
        skus.count
    }

    // MARK: - Private Properties

    private let dataService: DataService
    private let formatter: CurrencyFormatter
    private var transactionsBySku: [String: [TransactionModel]] = [:]
    private var rates: [RateModel] = []
    private var skus: [String] = []

    // MARK: - Initializers

    init(dataService: DataService = .shared, formatter: CurrencyFormatter = CurrencyFormatter()) {
        self.dataService = dataService
        self.formatter = formatter
    }

    // MARK: - Public Methods

    func loadProducts() {
        let transactions = dataService.loadTransactions()
        rates = dataService.loadRates()
        transactionsBySku = Dictionary(grouping: transactions) { $0.sku }
        skus = transactionsBySku.keys.sorted()
    }

    func sku(at index: Int) -> String {
        skus[index]
    }

    func transactionCount(at index: Int) -> Int {
        transactionsBySku[skus[index]]?.count ?? 0
    }

    func makeDetailViewModel(at index: Int) -> TransactionsDetailViewModel {
        let sku = skus[index]
        let transactions = transactionsBySku[sku] ?? []
        return TransactionsDetailViewModel(
            sku: sku,
            transactions: transactions,
            rates: rates,
            formatter: formatter
        )
    }
}
