import Foundation

struct AmountConversionService {
    private let graphResolver: SettlementCurrencyGraphResolver
    private let currencyCodeValidator: CurrencyCodeValidator

    init(graphResolver: SettlementCurrencyGraphResolver = SettlementCurrencyGraphResolver(),
         currencyCodeValidator: CurrencyCodeValidator = CurrencyCodeValidator()) {
        self.graphResolver = graphResolver
        self.currencyCodeValidator = currencyCodeValidator
    }

    func convertedAmount(of amount: Decimal, from source: String, to target: String, rates: [Rate]) throws -> Decimal {
        guard currencyCodeValidator.isValid(source), currencyCodeValidator.isValid(target) else {
            throw CurrencyConversionError.unresolvableRoute(from: source, to: target)
        }
        guard let factor = graphResolver.conversionRate(from: source, to: target, rates: rates) else {
            throw CurrencyConversionError.unresolvableRoute(from: source, to: target)
        }
        return amount * factor
    }
}
