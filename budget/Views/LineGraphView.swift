//
//  LineGraphView.swift
//  budget
//
//  Created by Edmund Xin on 5/12/24.
//

import Foundation
import SwiftUI
import Charts

struct LineGraphView: View {
    var dataPoints: [ChartDataEntry]
    var lineColor: Color = .blue
    
    var body: some View {
        let showZeroLine = dataPoints.contains { $0.value < 0 }
        
        VStack {
            Chart {
                ForEach(dataPoints, id: \.time) { point in
                    LineMark(
                        x: .value("Time", point.time),
                        y: .value("Net Worth", point.value)
                    )
                    .lineStyle(.init(lineWidth: 3))
                    .foregroundStyle(.blue)
                    .interpolationMethod(.cardinal(tension: 0.8))
                }
                
                
                ForEach(dataPoints, id: \.time) { point in
                    AreaMark(
                        x: .value("Time", point.time),
                        y: .value("Net Worth", point.value)
                    )
                    .foregroundStyle(lineColor.opacity(0.2))
                }
                
                if showZeroLine {
                    RuleMark(y: .value("Zero Line", 0))
                        .lineStyle(StrokeStyle(lineWidth: 3, dash: [5], dashPhase: 0))
                        .foregroundStyle(.gray)
                }
                
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .padding(20)
        }
        .frame(height: UIScreen.main.bounds.height / 4)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .padding([.leading, .trailing], 16)
        
    }
    
//    struct RoundedDottedLine: Shape {
//        func path(in rect: CGRect) -> Path {
//            var path = Path()
//            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
//            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
//            return path
//        }
//    }
    
//    func createSegments(dataPoints: [NetWorthData]) -> [[NetWorthData]] {
//        var segments = [[NetWorthData]]()
//        var currentSegment = [NetWorthData]()
//        
//        for i in 0..<dataPoints.count {
//            if i == 0 || (dataPoints[i].value < 0) == (dataPoints[i-1].value < 0) {
//                currentSegment.append(dataPoints[i])
//            } else {
//                segments.append(currentSegment)
//                currentSegment = [dataPoints[i]]
//            }
//        }
//        if !currentSegment.isEmpty {
//            segments.append(currentSegment)
//        }
//        return segments
//    }
}

struct NetWorthData: Identifiable {
    var id = UUID()
    var time: Int
    var value: Int
}

struct LineGraphView_Preview: PreviewProvider {
    static var previews: some View {
        let transactions = [
            FinancialData(date: Date().addingTimeInterval(-86400 * 7), netWorth: 13000),  // 7 days ago
            FinancialData(date: Date().addingTimeInterval(-86400 * 6), netWorth: 13300),  // 6 days ago
            FinancialData(date: Date().addingTimeInterval(-86400 * 5), netWorth: 13200),  // 5 days ago
            FinancialData(date: Date().addingTimeInterval(-86400 * 4), netWorth: 13100),  // 4 days ago
            FinancialData(date: Date().addingTimeInterval(-86400 * 3), netWorth: 13500),  // 3 days ago
            FinancialData(date: Date().addingTimeInterval(-86400 * 2), netWorth: 13700),  // 2 days ago
            FinancialData(date: Date().addingTimeInterval(-86400 * 1), netWorth: 14000),  // 1 day ago
            FinancialData(date: Date(), netWorth: 14200)                                  // Today
        ]
        let chartData = transactions.enumerated().map { (index, entry) in ChartDataEntry(time: index, value: entry.netWorth) }

        LineGraphView(dataPoints: chartData)
    }
}
