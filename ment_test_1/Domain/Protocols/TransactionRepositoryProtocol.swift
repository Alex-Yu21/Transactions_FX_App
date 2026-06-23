protocol TransactionRepositoryProtocol {
    func fetchTransactions() -> [Transaction]
    func fetchRates() -> [Rate]
}
