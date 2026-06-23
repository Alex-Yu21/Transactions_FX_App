import Foundation

struct TransactionDetailItemsBuilder {
    private let conversionService: AmountConversionService

    init(conversionService: AmountConversionService = AmountConversionService()) {
        self.conversionService = conversionService
    }

    func build(from transactions: [Transaction], settlementCurrency: String, rates: [Rate]) -> [TransactionDetailLine] {
        let factorByCurrency = conversionFactors(for: transactions, settlementCurrency: settlementCurrency, rates: rates)

        return transactions.map { transaction in
            let factor = factorByCurrency[transaction.currency] ?? 0
            return TransactionDetailLine(
                originalAmount: transaction.amount,
                originalCurrency: transaction.currency,
                convertedAmount: transaction.amount * factor,
                convertedCurrency: settlementCurrency
            )
        }
    }
}

// Private Methods
private extension TransactionDetailItemsBuilder {
    func conversionFactors(for transactions: [Transaction], settlementCurrency: String, rates: [Rate]) -> [String: Decimal] {
        let distinctCurrencies = Set(transactions.map { $0.currency })
        var factorByCurrency: [String: Decimal] = [:]
        for currency in distinctCurrencies {
            factorByCurrency[currency] = (try? conversionService.convertedAmount(of: 1, from: currency, to: settlementCurrency, rates: rates)) ?? 0
        }
        return factorByCurrency
    }
}
