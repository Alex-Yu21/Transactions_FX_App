import Foundation

struct SettlementCurrencyGraphResolver {
    func conversionRate(from source: String, to target: String, rates: [Rate]) -> Decimal? {
        if source == target {
            return 1
        }

        var visitedCurrencies: Set<String> = [source]
        var queue: [(currency: String, factor: Decimal)] = [(currency: source, factor: 1)]
        var headIndex = 0

        while headIndex < queue.count {
            let node = queue[headIndex]
            headIndex += 1

            for edge in edges(from: node.currency, rates: rates) where !visitedCurrencies.contains(edge.destination) {
                let accumulatedFactor = node.factor * edge.factor
                if edge.destination == target {
                    return accumulatedFactor
                }
                visitedCurrencies.insert(edge.destination)
                queue.append((currency: edge.destination, factor: accumulatedFactor))
            }
        }

        return nil
    }
}

// Private Methods
private extension SettlementCurrencyGraphResolver {
    func edges(from currency: String, rates: [Rate]) -> [(destination: String, factor: Decimal)] {
        var result: [(destination: String, factor: Decimal)] = []
        for rate in rates {
            if rate.from == currency, rate.value != 0 {
                result.append((destination: rate.to, factor: rate.value))
            }
            if rate.to == currency, rate.value != 0 {
                result.append((destination: rate.from, factor: 1 / rate.value))
            }
        }
        return result
    }
}
