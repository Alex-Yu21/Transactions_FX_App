import Foundation

struct TransactionDTO {
    let amount: Decimal
    let currency: String
    let sku: String
}

// Decodable
extension TransactionDTO: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let amountText = try container.decode(String.self, forKey: .amount)
        amount = Decimal(string: amountText) ?? 0
        currency = try container.decode(String.self, forKey: .currency)
        sku = try container.decode(String.self, forKey: .sku)
    }
}

// Domain Mapping
extension TransactionDTO {
    func toDomain() -> Transaction {
        Transaction(amount: amount, currency: currency, sku: sku)
    }
}

// CodingKeys
extension TransactionDTO {
    enum CodingKeys: String, CodingKey {
        case amount
        case currency
        case sku
    }
}
