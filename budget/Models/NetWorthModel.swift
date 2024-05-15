//
//  File.swift
//  budget
//
//  Created by Edmund Xin on 5/14/24.
//

import Foundation

struct FinancialData {
    var date: Date
    var netWorth: Double
}

class NetWorthModel {
    let sampleFinancialData: [FinancialData] = [
        FinancialData(date: Date().addingTimeInterval(-86400 * 30), netWorth: 10000), // 30 days ago
        FinancialData(date: Date().addingTimeInterval(-86400 * 29), netWorth: 1000), // 29 days ago
        FinancialData(date: Date().addingTimeInterval(-86400 * 28), netWorth: 120), // 28 days ago
        FinancialData(date: Date().addingTimeInterval(-86400 * 27), netWorth: 6700), // 27 days ago
        FinancialData(date: Date().addingTimeInterval(-86400 * 26), netWorth: 3200), // 26 days ago
        FinancialData(date: Date().addingTimeInterval(-86400 * 25), netWorth: -10300), // 25 days ago
        FinancialData(date: Date().addingTimeInterval(-86400 * 24), netWorth: -33100), // 24 days ago
        FinancialData(date: Date().addingTimeInterval(-86400 * 23), netWorth: 10400), // 23 days ago
        FinancialData(date: Date().addingTimeInterval(-86400 * 22), netWorth: 10700), // 22 days ago
        FinancialData(date: Date(), netWorth: 14200)                                  // Today
    ]
    
    func getNetWorthData() -> [FinancialData] {
        return sampleFinancialData
    }
    
    func calculateAccumulatedNetWorth() -> [FinancialData] {
          var accumulatedEntries: [FinancialData] = []
          var totalNetWorth: Double = 0

        for (index, entry) in sampleFinancialData.enumerated() {
              totalNetWorth += entry.netWorth
              accumulatedEntries.append(FinancialData(date: entry.date, netWorth: totalNetWorth))
          }

          return accumulatedEntries
      }
}
