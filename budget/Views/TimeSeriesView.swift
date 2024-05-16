//
//  LineGraphView.swift
//  budget
//
//  Created by Edmund Xin on 5/12/24.
//

import Foundation
import SwiftUI
import Charts

struct TimeSeriesView: View {
    var dataPoints: [ChartDataEntry]
    var lineColor: Color = .blue
    
    @State private var touchLocation: CGPoint = .zero
    @State private var showTooltip: Bool = false
    @State private var selectedDataPoint: ChartDataEntry?
    
    var body: some View {
        let maxX = dataPoints.map { $0.time }.max() ?? 0
        let maxY = dataPoints.map { $0.value }.max() ?? 0

        VStack {
            LineChartView(dataPoints: dataPoints.map { DataPoint(x: Double($0.time) / Double(maxX), y: $0.value / Double(maxY)) })
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

    }
    private func updateSelectedDataPoint(at location: CGPoint) {
        let chartWidth = UIScreen.main.bounds.width - 32
        let xPosition = location.x - 16  // Adjust for padding
        let step = chartWidth / CGFloat(dataPoints.count - 1)
        let index = Int((xPosition / step).rounded())
        
        if index >= 0 && index < dataPoints.count {
            selectedDataPoint = dataPoints[index]
        }
    }
}

struct NetWorthData: Identifiable {
    var id = UUID()
    var time: Int
    var value: Int
}

struct TimeSeriesView_Preview: PreviewProvider {
    static var previews: some View {
        let transactions = [
            TransactionData(date: Date().addingTimeInterval(-86400 * 7), amount: 13000),  // 7 days ago
            TransactionData(date: Date().addingTimeInterval(-86400 * 7), amount: 13000),  // 7 days ago
            TransactionData(date: Date().addingTimeInterval(-86400 * 6), amount: 13300),  // 6 days ago
            TransactionData(date: Date().addingTimeInterval(-86400 * 5), amount: 13200),  // 5 days ago
            TransactionData(date: Date().addingTimeInterval(-86400 * 4), amount: 13100),  // 4 days ago
            TransactionData(date: Date().addingTimeInterval(-86400 * 3), amount: 13500),  // 3 days ago
            TransactionData(date: Date().addingTimeInterval(-86400 * 2), amount: 13700),  // 2 days ago
            TransactionData(date: Date().addingTimeInterval(-86400 * 1), amount: 14000),  // 1 day ago
            TransactionData(date: Date(), amount: 14200)                                  // Today
        ]
        let chartData = transactions.enumerated().map { (index, entry) in ChartDataEntry(time: index, value: entry.amount) }
        
        TimeSeriesView(dataPoints: chartData)
    }
}
