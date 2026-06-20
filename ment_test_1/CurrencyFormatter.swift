import Foundation

final class CurrencyFormatter {
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = Constants.fractionDigits
        formatter.maximumFractionDigits = Constants.fractionDigits
        return formatter
    }()

    func string(for amount: Double, currency: String) -> String {
        symbol(for: currency) + formattedNumber(amount)
    }
}

// Private Methods
private extension CurrencyFormatter {
    func symbol(for currency: String) -> String {
        switch currency {
        case "USD":
            return "$"
        case "GBP":
            return "£"
        case "AUD":
            return "A$"
        case "CAD":
            return "CA$"
        default:
            return currency
        }
    }

    func formattedNumber(_ value: Double) -> String {
        numberFormatter.string(from: value as NSNumber) ?? "\(value)"
    }
}

// Constants
private extension CurrencyFormatter {
    enum Constants {
        static let fractionDigits = 2
    }
}
