//
//  NetWorthView.swift
//  budget
//
//  Created by ByteDance on 5/14/24.
//

import SwiftUI

struct NetWorthView: View {
    @ObservedObject var netWorthViewModel: NetWorthViewModel
    
    var body: some View {
        LineGraphView(dataPoints: netWorthViewModel.chartData).padding(.top, 16)
        Spacer()
    }
}

struct NetWorthView_Preview: PreviewProvider {
    static var previews: some View {
        let financialModel = NetWorthModel()
        let viewModel = NetWorthViewModel(model: financialModel)
        
        return NetWorthView(netWorthViewModel: viewModel)
    }
}
