import Foundation

final class DataService {
    static let shared = DataService()

    private init() {}

    func loadRates() -> [RateModel] {
        load(resource: Constants.ratesResource)
    }

    func loadTransactions() -> [TransactionModel] {
        load(resource: Constants.transactionsResource)
    }
}

// Private Methods
private extension DataService {
    func load<Item: Decodable>(resource: String) -> [Item] {
        guard let url = Bundle.main.url(forResource: resource, withExtension: Constants.fileExtension) else {
            return []
        }
        guard let data = try? Data(contentsOf: url) else {
            return []
        }
        guard let items = try? PropertyListDecoder().decode([Item].self, from: data) else {
            return []
        }
        return items
    }
}

// Constants
private extension DataService {
    enum Constants {
        static let ratesResource = "rates"
        static let transactionsResource = "transactions"
        static let fileExtension = "plist"
    }
}
