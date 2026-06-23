enum CurrencyConversionError: Error {
    case unresolvableRoute(from: String, to: String)
}
