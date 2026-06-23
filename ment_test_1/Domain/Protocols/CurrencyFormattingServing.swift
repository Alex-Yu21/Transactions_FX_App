import Foundation

protocol CurrencyFormattingServing {
    func string(for amount: Decimal, currencyCode: String) -> String
}
