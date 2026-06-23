import Foundation

struct RateDTO {
    let from: String
    let to: String
    let rate: Decimal
}

// Decodable
extension RateDTO: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        from = try container.decode(String.self, forKey: .from)
        to = try container.decode(String.self, forKey: .to)
        let rateText = try container.decode(String.self, forKey: .rate)
        rate = Decimal(string: rateText) ?? 0
    }
}

// Domain Mapping
extension RateDTO {
    func toDomain() -> Rate {
        Rate(from: from, to: to, value: rate)
    }
}

// CodingKeys
extension RateDTO {
    enum CodingKeys: String, CodingKey {
        case from
        case to
        case rate
    }
}
