//
//  ContentView.swift
//  budget
//
//  Created by Edmund Xin on 5/12/24.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        let financialModel = NetWorthModel()
        let viewModel = NetWorthViewModel(model: financialModel)
        
        return NetWorthView(netWorthViewModel: viewModel)
    }
}

#Preview {
    DashboardView()
}
