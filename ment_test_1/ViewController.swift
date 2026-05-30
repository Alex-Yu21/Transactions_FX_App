//
//  ViewController.swift
//  ment_test_1
//
//  Created by sun on 3/13/26.
//

import UIKit

class ViewController: UITableViewController {
    
    var transactions: [TransactionModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let transactions = DataService().loadTransactions()
    }


}

