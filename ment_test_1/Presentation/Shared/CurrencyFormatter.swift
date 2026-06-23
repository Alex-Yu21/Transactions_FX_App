import Foundation

final class CurrencyFormatter {
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
}

// CurrencyFormattingServing
extension CurrencyFormatter: CurrencyFormattingServing {
    func string(for amount: Decimal, currencyCode: String) -> String {
        numberFormatter.currencyCode = currencyCode
        numberFormatter.currencySymbol = symbol(for: currencyCode)
        return numberFormatter.string(from: NSDecimalNumber(decimal: amount)) ?? "\(amount)"
    }
}

// Private Methods
private extension CurrencyFormatter {
    func symbol(for currencyCode: String) -> String {
        switch currencyCode {
        case "USD":
            return "$"
        case "GBP":
            return "£"
        case "AUD":
            return "A$"
        case "CAD":
            return "CA$"
        default:
            return currencyCode + " "
        }
    }
}
