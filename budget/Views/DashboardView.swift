//
//  ContentView.swift
//  budget
//
//  Created by Edmund Xin on 5/12/24.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            LineGraphView(dataPoints: [10, 20, 50, 20])
        }
        .padding()
    }
}

#Preview {
    DashboardView()
}
