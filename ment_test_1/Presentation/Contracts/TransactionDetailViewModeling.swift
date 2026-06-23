protocol TransactionDetailViewModeling {
    var screenTitle: String { get }
    var itemCount: Int { get }
    var totalText: String { get }
    func item(at index: Int) -> TransactionDetailItem
}
