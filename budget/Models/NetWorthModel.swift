//
//  File.swift
//  budget
//
//  Created by Edmund Xin on 5/14/24.
//

import Foundation

struct TransactionData {
    var date: Date
    var amount: Double
}

class NetWorthModel {
    let sampleTransactionData: [TransactionData] = [
        TransactionData(date: Date().addingTimeInterval(-86400 * 6), amount: 10000),
        TransactionData(date: Date().addingTimeInterval(-86400 * 6), amount: 1000),
        TransactionData(date: Date().addingTimeInterval(-86400 * 4), amount: -11000),
        TransactionData(date: Date().addingTimeInterval(-86400 * 4), amount: 6700),
        TransactionData(date: Date().addingTimeInterval(-86400 * 3), amount: 3200),
        TransactionData(date: Date().addingTimeInterval(-86400 * 1), amount: -10300),
        TransactionData(date: Date().addingTimeInterval(-86400 * 1), amount: -33100),
        TransactionData(date: Date().addingTimeInterval(-86400 * 1), amount: 10400),
        TransactionData(date: Date().addingTimeInterval(-86400 * 1), amount: 10700),
        TransactionData(date: Date(), amount: 14200)                                  // Today
    ]
    
    func getNetWorthData() -> [TransactionData] {
        return sampleTransactionData
    }
    
}
