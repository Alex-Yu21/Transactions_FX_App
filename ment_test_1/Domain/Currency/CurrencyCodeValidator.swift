struct CurrencyCodeValidator {
    func isValid(_ code: String) -> Bool {
        code.count == Constants.expectedLength && code.allSatisfy { $0.isLetter }
    }
}

// Constants
private extension CurrencyCodeValidator {
    enum Constants {
        static let expectedLength = 3
    }
}
