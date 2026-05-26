//
//  DataService.swift
//  ment_test_1
//
//  Created by sun on 3/13/26.
//
import Foundation

struct DataService {
    func loadRates() -> [RateModel] {
        guard let url = Bundle.main.url(forResource: "rates", withExtension: "plist" )
        else {  return []
        }
    }
}
  


