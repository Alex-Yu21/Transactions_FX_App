
struct CurrencyConverter {
    let rates: [RateModel]

    func convert(amount: Double, from sourceCurrency: String, to targetCurrency: String) -> Double? {
        convert(amount: amount, from: sourceCurrency, to: targetCurrency, visitedCurrencies: [])
    }
}

// Private Methods
private extension CurrencyConverter {
    func convert(amount: Double, from sourceCurrency: String, to targetCurrency: String, visitedCurrencies: [String]) -> Double? {
        if sourceCurrency == targetCurrency {
            return amount
        }

        if let directRate = rates.first(where: { $0.from == sourceCurrency && $0.to == targetCurrency }) {
            return amount * directRate.rate
        }

        for rate in rates where rate.from == sourceCurrency && !visitedCurrencies.contains(rate.to) {
            let convertedAmount = amount * rate.rate
            let nextVisited = visitedCurrencies + [sourceCurrency]
            if let result = convert(amount: convertedAmount, from: rate.to, to: targetCurrency, visitedCurrencies: nextVisited) {
                return result
            }
        }

        return nil
    }
}
