//
//  TransactionsDetailViewController.swift
//  ment_test_1
//
//  Created by sun on 6/1/26.
//

import UIKit

class TransactionsDetailViewController: UITableViewController {
    var sku: String = ""
    var transactions: [TransactionModel] = []
    var rates: [RateModel] = []
    
    var converter: CurrencyConverter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transactions for \(sku)"
        converter = CurrencyConverter(rates: rates)
    }
    
    func symbol(for currency: String) -> String {
        switch currency {
        case "USD": return "$"
        case "GBP": return "£"
        case "AUD": return "A$"
        case "CAD": return "CA$"
        default: return currency
        }
    }
    
    func formatNumber(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ??
            "\(value)"
    }
    
    func money(_ value: Double, _ currency: String) -> String {
        return symbol(for: currency) + formatNumber(value)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let transaction = transactions[indexPath.row]
        let gbpAmount = converter?.convert(amount: transaction.amount,
                                           from: transaction.currency, to: "GBP") ?? 0
          
        cell.textLabel?.text = money(transaction.amount,
                                     transaction.currency)
        cell.detailTextLabel?.text = money(gbpAmount, "GBP")
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var total = 0.0
        for transaction in transactions {
            total += converter?.convert(amount: transaction.amount,
                                        from: transaction.currency, to: "GBP") ?? 0
        }
        return "Total: \(money(total, "GBP"))"
    }
}
