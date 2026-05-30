//
//  DataService.swift
//  ment_test_1
//
//  Created by sun on 3/13/26.
//
import Foundation

struct DataService {
    func loadRates() -> [RateModel] {
        guard let url = Bundle.main.url(forResource: "rates", withExtension: "plist")
        else { return []
        }
        
        guard let data = try? Data(contentsOf: url)
        else {
            return []
        }
        
        guard let array = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [[String: Any]]
        else {
            return []
        }
        
        var rates: [RateModel] = []

        for dictionary in array {
            guard let rateString = dictionary["rate"] as? String,
                    let rate = Double(rateString),
                    let from = dictionary["from"] as? String,
                    let to = dictionary["to"] as? String
              else {
                  continue
              }
            let rateModel = RateModel(from: from, to: to, rate: rate)
            
            rates.append(rateModel)
        }
        
        return rates

        
    }
    
    func loadTransactions() -> [TransactionModel] {
        guard let url = Bundle.main.url(forResource: "transactions", withExtension: "plist")
        else { return []
        }
        
        guard let data = try? Data(contentsOf: url)
        else {
            return []
        }
        
        guard let array = try? PropertyListSerialization.propertyList(from: data, format: nil) as?
                [[String: Any]]
        else {
            return []
        }
        
        var transactions: [TransactionModel] = []

        for dictionary in array {
            guard let amountString = dictionary["amount"] as? String,
                    let amount = Double(amountString),
                    let currency = dictionary["currency"] as? String,
                    let sku = dictionary["sku"] as? String
              else {
                  continue
              }
            let transactionModel = TransactionModel(amount: amount, currency: currency, sku: sku)
            
            transactions.append(transactionModel)
        }
        
        return transactions

    }
    
}
  
