//
//  NetWorthViewModel.swift
//  budget
//
//  Created by ByteDance on 5/14/24.
//

import Foundation

class NetWorthViewModel: ObservableObject {
    @Published var chartData: [TransactionData] = []
    private var netWorthModel: NetWorthModel
    
    init(model: NetWorthModel) {
        self.netWorthModel = model
        chartData = model.sampleTransactionData
    }
    
    func groupTransactionsByDay(transactions: [TransactionData]) -> [TransactionData] {
        debugPrint(transactions)
        let currentDate = Date()
        let calendar = Calendar.current
        
        var transactionDict: [Date: Double] = [:]
        
        // Populate the dictionary with the dates for the past seven days and set their initial values to 0
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: -i, to: currentDate) {
                let startOfDay = calendar.startOfDay(for: date)
                transactionDict[startOfDay] = 0.0
            }
        }
        
        // Iterate through the original array and update the dictionary
        for TransactionData in transactions {
            let startOfDay = calendar.startOfDay(for: TransactionData.date)
            if transactionDict.keys.contains(startOfDay) {
                transactionDict[startOfDay]! += TransactionData.amount
            }
        }
        
        // Convert the dictionary to an array of TransactionData objects
        var result: [TransactionData] = []
        for (date, transactionValue) in transactionDict {
            result.append(TransactionData(date: date, amount: transactionValue))
        }
        
        // Sort the result by date
        result.sort { $0.date < $1.date }
        
        debugPrint(result)
        
        return result
    }
    
    func calculateAccumulatedNetWorth(transactions: [TransactionData]) -> [TransactionData] {
        var accumulatedEntries: [TransactionData] = []
        var totalNetWorth: Double = 0
        
        for (_, entry) in transactions.enumerated() {
            totalNetWorth += entry.amount
            accumulatedEntries.append(TransactionData(date: entry.date, amount: totalNetWorth))
        }
        
        return accumulatedEntries
    }
}


struct ChartDataEntry {
    var time: Int
    var value: Double
}
