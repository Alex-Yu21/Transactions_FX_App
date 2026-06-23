import Foundation

struct SettlementTotalAggregator {
    func total(of lines: [TransactionDetailLine]) -> Decimal {
        lines.reduce(into: Decimal.zero) { runningTotal, line in
            runningTotal += line.convertedAmount
        }
    }
}
