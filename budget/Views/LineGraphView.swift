//
//  LineGraphView.swift
//  budget
//
//  Created by Edmund Xin on 5/12/24.
//

import Foundation
import SwiftUI

struct LineGraphView: View {
    var dataPoints: [CGFloat]
    var lineColor: Color = .blue

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                let maxPoint = dataPoints.max() ?? 0
                let minPoint = dataPoints.min() ?? 0

                let verticalScale = height / (maxPoint - minPoint)
                for (index, point) in dataPoints.enumerated() {
                    let xPosition = width * CGFloat(index) / CGFloat(dataPoints.count - 1)
                    let yPosition = (point - minPoint) * verticalScale

                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: height - yPosition))
                    } else {
                        path.addLine(to: CGPoint(x: xPosition, y: height - yPosition))
                    }
                }
            }.stroke(lineColor, lineWidth: 2)
        }.padding()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1))
            .frame(height: 200)
            .padding()
    }
}

struct LineGraphView_Preview: PreviewProvider {
    static var previews: some View {
        LineGraphView(dataPoints: [10, 50, 30, 70, 40]).frame(height: 200).padding()
    }
}
