struct SKUListAggregator {
    func aggregate(_ transactions: [Transaction]) -> [ProductGroup] {
        Dictionary(grouping: transactions, by: { $0.sku })
            .map { ProductGroup(sku: $0.key, transactions: $0.value) }
            .sorted { $0.sku < $1.sku }
    }
}
