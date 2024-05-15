//
//  NetWorthViewModel.swift
//  budget
//
//  Created by ByteDance on 5/14/24.
//

import Foundation

class NetWorthViewModel: ObservableObject {
    @Published var chartData: [ChartDataEntry] = []
    private var netWorthModel: NetWorthModel
    
    init(model: NetWorthModel) {
        self.netWorthModel = model
        self.loadChartData()
    }
    
    func loadChartData() {
        let data = netWorthModel.calculateAccumulatedNetWorth()
        chartData = data.enumerated().map { (index, entry) in ChartDataEntry(time: index, value: entry.netWorth) }
    }
}


struct ChartDataEntry {
    var time: Int
    var value: Double
}
