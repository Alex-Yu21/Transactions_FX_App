
struct TransactionModel {
    let amount: Double
    let currency: String
    let sku: String
}

//  Decodable
extension TransactionModel: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let amountText = try container.decode(String.self, forKey: .amount)
        amount = Double(amountText) ?? 0
        currency = try container.decode(String.self, forKey: .currency)
        sku = try container.decode(String.self, forKey: .sku)
    }
}

// CodingKeys
extension TransactionModel {
    enum CodingKeys: String, CodingKey {
        case amount
        case currency
        case sku
    }
}
