//
//  ViewController.swift
//  ment_test_1
//
//  Created by sun on 3/13/26.
//

import UIKit

class ViewController: UITableViewController {
    var transactions: [TransactionModel] = []
    var groupedTransactions: [String: [TransactionModel]] = [:]
    var skus: [String] = []
    var rates: [RateModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Products"
        rates = DataService().loadRates()
        transactions = DataService().loadTransactions()
        groupedTransactions = Dictionary(grouping: transactions, by: { $0.sku })
        skus = Array(groupedTransactions.keys).sorted()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let sku = skus[indexPath.row]
                let detail = segue.destination as! TransactionsDetailViewController
                
                detail.sku = sku
                detail.transactions = groupedTransactions[sku] ?? []
                detail.rates = rates
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skus.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let sku = skus[indexPath.row]
        let count = groupedTransactions[sku]?.count ?? 0
        
        cell.textLabel?.text = sku
        cell.detailTextLabel?.text = "\(count) transactions"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
         cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18)
        
        return cell
    }
}
