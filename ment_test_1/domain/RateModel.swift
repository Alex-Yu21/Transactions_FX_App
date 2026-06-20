//
//  Copyright © 2026 ment_test_1. All rights reserved.
//

struct RateModel {
    let from: String
    let to: String
    let rate: Double
}

// Decodable
extension RateModel: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        from = try container.decode(String.self, forKey: .from)
        to = try container.decode(String.self, forKey: .to)
        let rateText = try container.decode(String.self, forKey: .rate)
        rate = Double(rateText) ?? 0
    }
}

// CodingKeys
extension RateModel {
    enum CodingKeys: String, CodingKey {
        case from
        case to
        case rate
    }
}
