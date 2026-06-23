protocol TransactionListViewModeling {
    var productCount: Int { get }
    func loadProducts(completion: @escaping () -> Void)
    func item(at index: Int) -> ProductListItem
    func makeDetailViewModel(at index: Int) -> TransactionDetailViewModeling
}
