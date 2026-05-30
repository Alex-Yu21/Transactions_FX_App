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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        transactions = DataService().loadTransactions()
        groupedTransactions = Dictionary(grouping: transactions, by: { $0.sku })
        skus = Array(groupedTransactions.keys).sorted()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return skus.count
      }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
          let sku = skus[indexPath.row]
          let count = groupedTransactions[sku]?.count ?? 0
          cell.textLabel?.text = "\(sku) — \(count) transactions"
          return cell
      }
}

