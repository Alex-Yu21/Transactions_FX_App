import Foundation

final class TransactionDetailViewModel {
    private let sku: String
    private let lines: [TransactionDetailLine]
    private let totalAmount: Decimal
    private let currencyFormatter: CurrencyFormattingServing
    private let settlementCurrency: String

    init(sku: String,
         transactions: [Transaction],
         rates: [Rate],
         itemsBuilder: TransactionDetailItemsBuilder = TransactionDetailItemsBuilder(),
         totalAggregator: SettlementTotalAggregator = SettlementTotalAggregator(),
         currencyFormatter: CurrencyFormattingServing = CurrencyFormatter(),
         settlementCurrency: String = ReferenceCurrencyCode.value) {
        self.sku = sku
        self.currencyFormatter = currencyFormatter
        self.settlementCurrency = settlementCurrency
        let builtLines = itemsBuilder.build(from: transactions, settlementCurrency: settlementCurrency, rates: rates)
        lines = builtLines
        totalAmount = totalAggregator.total(of: builtLines)
    }
}

// TransactionDetailViewModeling
extension TransactionDetailViewModel: TransactionDetailViewModeling {
    var screenTitle: String {
        String(format: NSLocalizedString("Transactions for %@", comment: "Detail screen title"), sku)
    }

    var itemCount: Int {
        lines.count
    }

    var totalText: String {
        let total = currencyFormatter.string(for: totalAmount, currencyCode: settlementCurrency)
        return String(format: NSLocalizedString("Total: %@", comment: "Total settlement amount"), total)
    }

    func item(at index: Int) -> TransactionDetailItem {
        let line = lines[index]
        return TransactionDetailItem(
            originalText: currencyFormatter.string(for: line.originalAmount, currencyCode: line.originalCurrency),
            convertedText: currencyFormatter.string(for: line.convertedAmount, currencyCode: line.convertedCurrency)
        )
    }
}
