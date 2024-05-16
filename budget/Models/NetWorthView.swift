//
//  NetWorthView.swift
//  budget
//
//  Created by ByteDance on 5/14/24.
//

import SwiftUI

struct NetWorthView: View {
    @ObservedObject var netWorthViewModel: NetWorthViewModel
    
    private var groupedData: [DataPoint] {
        let transactionsByDay = netWorthViewModel.groupTransactionsByDay(transactions: netWorthViewModel.chartData)
        let accumulatedNetWorth = netWorthViewModel.calculateAccumulatedNetWorth(transactions: transactionsByDay)
        return accumulatedNetWorth.map { DataPoint(x: Double($0.date.timeIntervalSince1970), y: Double($0.amount)) }
    }
    
    var body: some View {
        VStack {
            LineChartView(dataPoints: groupedData)
        }
        .frame(height: UIScreen.main.bounds.height / 4)
        .padding(20)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .padding([.leading, .trailing], 16)
        .onAppear {
            debugPrint(groupedData)
        }
    }
}

struct NetWorthView_Preview: PreviewProvider {
    static var previews: some View {
        let financialModel = NetWorthModel()
        let viewModel = NetWorthViewModel(model: financialModel)
        
        return NetWorthView(netWorthViewModel: viewModel)
    }
}
