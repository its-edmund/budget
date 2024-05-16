//
//  LineChart.swift
//  budget
//
//  Created by ByteDance on 5/15/24.
//

import SwiftUI

struct DataPoint {
    let x: Double
    let y: Double
    var highlighted: Bool = false
}

struct LineChartView: View {
    var dataPoints: [DataPoint]
    var lineColor: Color = .green
    var areaColor: Color = .green
    var axisColor: Color = .gray
    var lighterAxisColor: Color = Color(white: 0.85, opacity: 1.0)
    var lighterLineColor: Color {
        lineColor.opacity(0.7) // Adjust opacity to make it lighter
    }
    @State private var dragLocation: CGPoint = .zero
    @State private var isDragging: Bool = false
    @State private var normalizedDataPoints: [DataPoint] = []
    
    var body: some View {
        let showZeroLine = dataPoints.contains { $0.y < 0 }
        let minY = dataPoints.map { $0.y }.min() ?? 0
        let maxY = dataPoints.map { $0.y }.max() ?? 1
        
        let normalizedZero = -minY / (maxY - minY)
        
        GeometryReader { geometry in
            ZStack {
                if showZeroLine {
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: geometry.size.height - normalizedZero * geometry.size.height))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height - normalizedZero * geometry.size.height))
                    }
                    .stroke(lighterAxisColor, style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [5]))
                }
                
                // Draw shaded area
                LinearGradient(gradient: Gradient(colors: [.green.opacity(0.3), .clear]),
                               startPoint: .top,
                               endPoint: UnitPoint(x: 0.5, y: showZeroLine ? normalizedZero : 1))
                .clipShape(createAreaPath(in: geometry.size))
                
                createLinePath(in: geometry.size)
                    .stroke(Color.green, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                dragLocation = value.location
                                isDragging = true
                            }
                            .onEnded { _ in
                                isDragging = false
                            }
                    )
                
                if isDragging {
                    let closestPoint = closestDataPoint(to: dragLocation, in: geometry.size)
                    
                    Path { path in
                        path.move(to: CGPoint(x: closestPoint.x, y: geometry.size.height))
                        path.addLine(to: CGPoint(x: closestPoint.x, y: closestPoint.y))
                    }
                    .stroke(lighterAxisColor, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 10, height: 10)
                        .overlay(
                            Circle().stroke(Color.green, lineWidth: 4)
                        )
                        .position(closestPoint)
                }
                
            }.onAppear{
                normalizedDataPoints = normalizeDataPoints(dataPoints: dataPoints)
            }
            
            
            
        }
    }
    
    private func createLinePath(in size: CGSize) -> Path {
        var path = Path()
        
        guard let firstPoint = normalizedDataPoints.first else { return path }
        let scaledFirstPoint = CGPoint(x: firstPoint.x * Double(size.width), y: size.height - firstPoint.y * Double(size.height))
        path.move(to: scaledFirstPoint)
        
        for dataPoint in normalizedDataPoints.dropFirst() {
            let scaledPoint = CGPoint(x: dataPoint.x * Double(size.width), y: size.height - dataPoint.y * Double(size.height))
            path.addLine(to: scaledPoint)
        }
        
        return path
    }
    
    private func createAreaPath(in size: CGSize) -> Path {
        var path = createLinePath(in: size)
        
        if let last = normalizedDataPoints.last {
            path.addLine(to: CGPoint(x: last.x * Double(size.width), y: size.height))
        }
        
        if let first = normalizedDataPoints.first {
            path.addLine(to: CGPoint(x: first.x * Double(size.width), y: size.height))
        }
        
        path.closeSubpath()
        
        return path
    }
    
    func normalizeDataPoints(dataPoints: [DataPoint]) -> [DataPoint] {
        guard !dataPoints.isEmpty else { return [] }
        
        // Find minimum and maximum x and y values
        let minX = dataPoints.map { $0.x }.min() ?? 0
        let maxX = dataPoints.map { $0.x }.max() ?? 1
        let minY = dataPoints.map { $0.y }.min() ?? 0
        let maxY = dataPoints.map { $0.y }.max() ?? 1
        
        // Normalize data points
        return dataPoints.map { DataPoint(x: ($0.x - minX) / (maxX - minX), y: ($0.y - minY) / (maxY - minY)) }
    }
    
    func closestDataPoint(to point: CGPoint, in size: CGSize) -> CGPoint {
        let normalizedX = point.x / size.width
        let closest = normalizedDataPoints.min(by: { abs($0.x - normalizedX) < abs($1.x - normalizedX) })!
        
        return CGPoint(x: closest.x * size.width, y: size.height - closest.y * Double(size.height))
    }
    
    func distance(from point: CGPoint, to dataPoint: DataPoint) -> CGFloat {
        let dx = point.x - dataPoint.x
        let dy = point.y - dataPoint.y
        return sqrt(dx * dx + dy * dy)
    }
}

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView(dataPoints: [
            DataPoint(x: 0, y: 0.5),
            DataPoint(x: 0.2, y: 0.2),
            DataPoint(x: 0.4, y: 0.6),
            DataPoint(x: 0.6, y: 0.9),
            DataPoint(x: 0.8, y: 0.7),
            DataPoint(x: 1, y: 1)
        ])
        .frame(width: 300, height: 200)
    }
}
