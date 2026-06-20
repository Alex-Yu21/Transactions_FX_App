//
//  Copyright © 2026 ment_test_1. All rights reserved.
//

final class TransactionsDetailViewModel {

    // MARK: - Public Properties

    var title: String {
        "Transactions for \(sku)"
    }

    var transactionCount: Int {
        transactions.count
    }

    var totalText: String {
        let total = transactions.reduce(into: 0.0) { runningTotal, transaction in
            runningTotal += convertedAmount(for: transaction)
        }
        return "Total: \(formatter.string(for: total, currency: Constants.baseCurrency))"
    }

    // MARK: - Private Properties

    private let sku: String
    private let transactions: [TransactionModel]
    private let converter: CurrencyConverter
    private let formatter: CurrencyFormatter

    // MARK: - Initializers

    init(sku: String, transactions: [TransactionModel], rates: [RateModel], formatter: CurrencyFormatter) {
        self.sku = sku
        self.transactions = transactions
        self.converter = CurrencyConverter(rates: rates)
        self.formatter = formatter
    }

    // MARK: - Public Methods

    func originalAmountText(at index: Int) -> String {
        let transaction = transactions[index]
        return formatter.string(for: transaction.amount, currency: transaction.currency)
    }

    func convertedAmountText(at index: Int) -> String {
        let transaction = transactions[index]
        return formatter.string(for: convertedAmount(for: transaction), currency: Constants.baseCurrency)
    }
}

// MARK: - Private Methods
private extension TransactionsDetailViewModel {
    func convertedAmount(for transaction: TransactionModel) -> Double {
        converter.convert(amount: transaction.amount, from: transaction.currency, to: Constants.baseCurrency) ?? 0
    }
}

// MARK: - Constants
private extension TransactionsDetailViewModel {
    enum Constants {
        static let baseCurrency = "GBP"
    }
}
