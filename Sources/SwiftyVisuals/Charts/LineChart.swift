//
//  SwiftUIView.swift
//  
//
//  Created by Nuno Alves de Sousa on 05/03/2021.
//

import SwiftUI

/// A view that presents a line chart of 2D data points or single, evenly spaced, y-values
public struct LineChart: View {
    @State private var isPresented = false
    
    var data: Either<[DataPoint], [DataValue]>
    var configuration = Configuration()
    
    public var body: some View {
        ZStack {
            chartGrid.zIndex(configuration.gridVerticalPosition.rawValue)
            chartData.zIndex(VerticalPosition.middle)
        }
        .onAppear { isPresented = true }
        .ifLet(chartWidth) { $0.frame(width: $1) }
    }
    
    var chartWidth: CGFloat? {
        guard let count = data.second?.count,
              let stepSize = configuration.stepSize else { return nil }
        return CGFloat(count - 1) * stepSize
    }
}

extension LineChart {
    func domain() -> Bounds {
        var bounds: Bounds
        if let points = data.first {
            bounds = Bounds(
                minX: configuration.minX ?? points.map(\.x).min()!,
                maxX: configuration.maxX ?? points.map(\.x).max()!,
                minY: configuration.minY ?? points.map(\.y).min()!,
                maxY: configuration.maxY ?? points.map(\.y).max()!)
        } else if let values = data.second {
            bounds = Bounds(
                minX: 0,
                maxX: CGFloat(values.count),
                minY: configuration.minY ?? values.map(\.y).min()!,
                maxY: configuration.maxY ?? values.map(\.y).max()!)
        } else {
            fatalError("LineChart.chartCoordinates: all data nil")
        }
        
        bounds.maxY = bounds.maxY == .zero ? 1 : bounds.maxY
        return bounds
    }
    
    func chartCoordinates(frameSize: CGSize) -> [CGPoint] {
        let chartDomain = domain()
        
        var coordinates: [CGPoint]
        if let points = data.first {
            coordinates = points.map {
                $0.toPointInChartFrame(domain: chartDomain, frameSize: frameSize)
            }
        } else if let values = data.second {
            let defaultStepSize: CGFloat = frameSize.width / CGFloat(values.count - 1)
            
            var x: CGFloat = 0
            coordinates = values.map {
                let point = CGPoint(
                    x: x,
                    y: $0.toValueInChartFrame(minY: chartDomain.minY,
                                              maxY: chartDomain.maxY,
                                              frameHeight: frameSize.height))
                x += configuration.stepSize ?? defaultStepSize
                return point
            }
        } else {
            fatalError("LineChart.chartCoordinates: all data nil")
        }
        return coordinates
    }
    
    func draw(path: inout Path, frameSize: CGSize) {
        let coordinates = chartCoordinates(frameSize: frameSize)
        var previousPoint = coordinates.first!
        
        path.move(to: previousPoint)
        coordinates.forEach { point in
            let dx = point.x - previousPoint.x
            let curveOffsetX = dx * configuration.lineRadius
            
            let control1 = CGPoint(x: previousPoint.x + curveOffsetX, y: previousPoint.y)
            let control2 = CGPoint(x: point.x - curveOffsetX, y: point.y)
            
            path.addCurve(to: point, control1: control1, control2: control2)
            
            previousPoint = point
        }
    }
    
    func path(frameSize: CGSize) -> Path {
        Path { path in
            draw(path: &path, frameSize: frameSize)
        }
    }
    
    func closedPath(frameSize: CGSize) -> Path {
        Path { path in
            draw(path: &path, frameSize: frameSize)
            let chartDomain = domain()
            let coordinates = chartCoordinates(frameSize: frameSize)
            
            let minYInChartFrame = ChartFrame.yInChartFrame(
                chartDomain.minY,
                minY: chartDomain.minY,
                maxY: chartDomain.maxY,
                height: frameSize.height)
            
            let right = CGPoint(x: coordinates.map(\.x).max()!,
                                y: minYInChartFrame)
            let left = CGPoint(x: coordinates.map(\.x).min()!,
                               y: minYInChartFrame)
            
            path.addLine(to: right)
            path.addLine(to: left)
        }
    }
    
    var chartData: some View {
        GeometryReader { geo in
            ZStack {
                closedPath(frameSize: geo.size)
                    .fill(configuration.fillStyle)
                    .mask(configuration.mask?.makeBody(isPresented: isPresented))
                    .ifLet(configuration.fillAnimation) { $0.animation($1) }
                
                path(frameSize: geo.frame(in: .local).size)
                    .trim(from: 0, to: isPresented ? 1 : 0 )
                    .stroke(anyShapeStyle: configuration.lineShapeStyle,
                            strokeStyle: configuration.lineStrokeStyle)
                    .ifLet(configuration.lineAnimation) { $0.animation($1) }
            }
        }
    }
}

extension LineChart {
    var chartGrid: some View {
        GeometryReader { geo in
            ZStack {
                Path { path in
                    drawXLines(path: &path, frameSize: geo.size)
                }
                .stroke(anyShapeStyle: configuration.xLineShapeStyle,
                        strokeStyle: configuration.xLineStrokeStyle)
                
                Path { path in
                    drawYLines(path: &path, frameSize: geo.size)
                }
                .stroke(anyShapeStyle: configuration.yLineShapeStyle,
                        strokeStyle: configuration.yLineStrokeStyle)
                
                xLabels(frameSize: geo.size)
                yLabels(frameSize: geo.size)
            }
        }
    }
    
    @ViewBuilder func xLabels(frameSize: CGSize) -> some View {
        if let xLabels = configuration.xLabels {
            customXLabels(xLabels: xLabels,
                         xLines: gridInChartFrame(frameSize: frameSize).xLines,
                         frameSize: frameSize)
        } else {
            defaultXLabels(xLines: gridInChartFrame(frameSize: frameSize).xLines,
                          frameSize: frameSize)
        }
    }
    
    func customXLabels(xLabels: [AnyView], xLines: [[CGPoint]], frameSize: CGSize) -> some View {
        ForEach(xLabels.indices) { index in
            if index != configuration.grid.xTicks.endIndex {
                xLabels[index]
                    .position(x: xLines[index].first!.x, y: frameSize.height)
                    .offset(x: configuration.xLabelXOffset, y: configuration.xLabelYOffset)
            }
        }
    }
    
    func defaultXLabels(xLines: [[CGPoint]], frameSize: CGSize) -> some View {
        ForEach(xLines.indices) { index in
            Text(configuration.grid.xTicks[index].toString())
                .font(configuration.xLabelFont)
                .foregroundColor(configuration.xLabelColor)
                .position(x: xLines[index].first!.x, y: frameSize.height)
                .offset(x: configuration.xLabelXOffset, y: configuration.xLabelYOffset)
        }
    }
    
    @ViewBuilder func yLabels(frameSize: CGSize) -> some View {
        if let yLabels = configuration.yLabels {
            customYLabels(yLabels: yLabels,
                         yLines: gridInChartFrame(frameSize: frameSize).yLines,
                         frameSize: frameSize)
        } else {
            defaultYLabels(yLines: gridInChartFrame(frameSize: frameSize).yLines,
                          frameSize: frameSize)
        }
    }
//    func yLabels(frameSize: CGSize) -> some View {
//        let yLines = gridInChartFrame(frameSize: frameSize).yLines
//
//        return ForEach(configuration.grid.yTicks.indices) { index in
//            Text(configuration.grid.yTicks[index].toString())
//                .font(configuration.yLabelFont)
//                .foregroundColor(configuration.yLabelColor)
//                .position(x: 0, y: yLines[index].first!.y)
//                .offset(x: configuration.yLabelXOffset, y: configuration.yLabelYOffset)
//        }
//    }
    
    func customYLabels(yLabels: [AnyView], yLines: [[CGPoint]], frameSize: CGSize) -> some View {
        ForEach(yLabels.indices) { index in
            if index != configuration.grid.yTicks.endIndex {
                yLabels[index]
                    .position(x: yLines[index].first!.x, y: yLines[index].first!.y)
                    .offset(x: configuration.yLabelXOffset, y: configuration.yLabelYOffset)
            }
        }
    }
    
    func defaultYLabels(yLines: [[CGPoint]], frameSize: CGSize) -> some View {
        ForEach(yLines.indices) { index in
            Text(configuration.grid.yTicks[index].toString())
                .font(configuration.yLabelFont)
                .foregroundColor(configuration.yLabelColor)
                .position(x: 0, y: yLines[index].first!.y)
                .offset(x: configuration.yLabelXOffset, y: configuration.yLabelYOffset)
        }
    }
    
    func drawXLines(path: inout Path, frameSize: CGSize) {
        let grid = gridInChartFrame(frameSize: frameSize)
        
        grid.xLines.forEach { line in
            path.addLines(line)
        }
    }
    
    func drawYLines(path: inout Path, frameSize: CGSize) {
        let grid = gridInChartFrame(frameSize: frameSize)
        
        grid.yLines.forEach { line in
            path.addLines(line)
        }
    }
    
    func gridInChartFrame(frameSize: CGSize) -> (xLines: [[CGPoint]], yLines: [[CGPoint]]) {
        let chartDomain = domain()
        
        let xLines: [[CGPoint]] = configuration.grid.xLines(
            minY: configuration.xLineMinY ?? chartDomain.minY,
            maxY: configuration.xLineMaxY ?? chartDomain.maxY).map { line in
                line.map { point in
                    point.toPointInChartFrame(domain: chartDomain, frameSize: frameSize)
                }
            }
        
        let yLines: [[CGPoint]] = configuration.grid.yLines(
            minX: configuration.yLineMinX ?? chartDomain.minX,
            maxX: configuration.yLineMaxX ?? chartDomain.maxX).map { line in
                line.map { point in
                    point.toPointInChartFrame(domain: chartDomain, frameSize: frameSize)
                }
            }
        
        return (xLines, yLines)
    }
}

struct LineChart_Previews: PreviewProvider {
    static let points: [DataPoint] = [
        .init(x: -5, y: 0), .init(x: -4, y: 1), .init(x: -3, y: -1), .init(x: -2, y: -2),
        .init(x: -1, y: 0), .init(x: 0, y: 1.3), .init(x: 1, y: 0), .init(x: 2, y: 2),
        .init(x: 3, y: 1), .init(x: 4, y: 3), .init(x: 5, y: 0)
    ]
    
    static let values: [DataValue] = [
        .init(y: 0), .init(y: 3), .init(y: 9), .init(y: 5), .init(y: 10), .init(y: 15)
    ]
    
    static let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.blue.opacity(0.75), Color.green.opacity(0.1)]),
        startPoint: .top,
        endPoint: .bottom)
    
    static let xLabels = [
        Text("-5"), Text("-4"), Text("-3"), Text("-2"), Text("-1"), Text("0"), Text("1"), Text("2"),
        Text("3"), Text("4"), Text("5")
    ].map { $0.font(.caption2) }
    
    static let yLabels = [
        Text("-2"), Text("-1"), Text("0"), Text("1"), Text("2"), Text("3")
    ].map { $0.font(.caption2) }
    
    static var previews: some View {
        VStack(spacing: 25) {
            LineChart(points: points)
                .limitis(minY: -3)
                .xGrid(from: -5, through: 5, by: 1)
                .yGrid(from: -2, through: 3, by: 1)
                .line(radius: 0.6, animation: Animation.easeInOut(duration: 3))
                .line(Color.blueDark, strokeStyle: StrokeStyle(lineWidth: 2))
                .fill(transition: .opacity,
                      animation: Animation.easeInOut(duration: 1.5).delay(1.5))
                .fill(animatableMask: AnyAnimatableMask
                        .rectangle(from: .leading)
                        .combined(with: .opacity),
                      animation: Animation.easeOut(duration: 1.5).delay(1.5))
                .fill(gradient)
                .labels(x: xLabels, y: yLabels)
                .frame(height: 200)
                .padding()
            
            LineChart(values: values)
                .xGrid(from: 0, through: 6, by: 2)
                .yGrid(from: 0, through: 15, by: 5)
                .line(radius: 0.6, animation: Animation.easeInOut(duration: 3))
                .line(Color.blueDark, strokeStyle: StrokeStyle(lineWidth: 3))
                .fill(transition: .opacity,
                      animation: Animation.easeInOut(duration: 1.5).delay(1.5))
                .fill(animatableMask: AnyAnimatableMask.rectangle(from: .leading).combined(with: .opacity),
                      animation: Animation.easeOut(duration: 1.5).delay(1.5))
                .fill(gradient)
                .frame(height: 200)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LineChart(values: values)
                    .grid(position: .back)
                    .limitis(minY: -3)
                    .stepSize(x: 130)
                    .line(radius: 0.6, animation: Animation.easeInOut(duration: 3))
                    .line(Color.blueDark, strokeStyle: StrokeStyle(lineWidth: 2))
                    .fill(transition: .opacity,
                          animation: Animation.easeInOut(duration: 1.5).delay(1.5))
                    .fill(animatableMask: AnyAnimatableMask.rectangle(from: .leading).combined(with: .opacity),
                          animation: Animation.easeOut(duration: 1.5).delay(1.5))
                    .fill(gradient)
                    .frame(height: 200)
            }
        }
    }
}
