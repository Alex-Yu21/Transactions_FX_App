//
//  CurrencyConverter.swift
//  ment_test_1
//
//  Created by sun on 5/30/26.
//

import Foundation


struct CurrencyConverter{
    let rates: [RateModel]
    
    func convert(amount: Double, from: String, to: String, seenRates: [String] = []) -> Double? {
        
        if from == to {
            return amount
        }
        
        for rate in rates {
            if rate.from == from && rate.to == to {
                return amount * rate.rate
            }
        }
        for rate in rates {
            if rate.from == from && !seenRates.contains(rate.to) {
                 if let result = convert(amount: amount * rate.rate,
         from: rate.to, to: to, seenRates: seenRates + [from]) {
                     return result
                 }
             }
         }

         return nil
    }
    
}

