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
            line
        }
        .onAppear { isPresented = true }
    }
}

extension LineChart {
    func chartCoordinates(frameSize: CGSize) -> [CGPoint] {
        var coordinates: [CGPoint]
        if let points = data.first {
            let chartDomain = Bounds(
                minX: configuration.minX ?? points.map(\.x).min()!,
                maxX: configuration.maxX ?? points.map(\.x).max()!,
                minY: configuration.minY ?? points.map(\.y).min()!,
                maxY: configuration.maxY ?? points.map(\.y).max()!)
            
            coordinates = points.map {
                $0.toPointInChartFrame(chartDomain: chartDomain, frameSize: frameSize)
            }
        } else if let values = data.second {
            let minY = configuration.minY ?? values.map(\.y).min()!
            let maxY = configuration.maxY ?? values.map(\.y).max()!
            let defaultStepSize: CGFloat = frameSize.width / CGFloat(values.count - 1)
            
            var x: CGFloat = 0
            coordinates = values.map {
                let point = CGPoint(
                    x: x,
                    y: $0.toValueInChartFrame(minY: minY, maxY: maxY, frameHeight: frameSize.height))
                x += configuration.stepSize ?? defaultStepSize
                return point
            }
        } else {
            fatalError("LineChart: all data nil")
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
            
            let coordinates = chartCoordinates(frameSize: frameSize)
            
            let right = CGPoint(x: coordinates.map(\.x).max()!, y: coordinates.map(\.y).max()!)
            let left = CGPoint(x: coordinates.map(\.x).min()!, y: coordinates.map(\.y).max()!)
            
            path.addLine(to: right)
            path.addLine(to: left)
        }
    }
    
    var line: some View {
        GeometryReader { geo in
            ZStack {
                closedPath(frameSize: geo.frame(in: .local).size)
                    .fill(configuration.fillStyle)
                    .mask(configuration.mask?.makeBody(isPresented: isPresented))
                    .ifLet(configuration.fillAnimation) { $0.animation($1) }
                
                path(frameSize: geo.frame(in: .local).size)
                    .trim(from: 0, to: isPresented ? 1 : 0 )
                    .stroke(configuration.strokeStyle, lineWidth: configuration.lineWidth)
                    .ifLet(configuration.lineAnimation) { $0.animation($1) }
            }
        }
    }
}


struct LineChart_Previews: PreviewProvider {
    static let points: [DataPoint] = [
        .init(x: -10, y: 7), .init(x: -8, y: 10), .init(x: -5, y: 2),
        .init(x: 0, y: 0),
        .init(x: 5, y: 3), .init(x: 7, y: 6), .init(x: 10, y: 12)
    ]
    
    static let gradient = LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.75),
                                                                     Color.green.opacity(0.1)]),
                                         startPoint: .top,
                                         endPoint: .bottom)
    
    static var previews: some View {
        LineChart(points: points)
            .line(radius: 0.6, animation: Animation.easeInOut(duration: 3))
            .stroke(Color.blueDark, lineWidth: 2)
            .fill(transition: .opacity,
                  animation: Animation.easeInOut(duration: 1.5).delay(1.5))
            .fill(animatableMask: AnyAnimatableMask.rectangle(from: .leading).combined(with: .opacity),
                  animation: Animation.easeOut(duration: 1.5).delay(1.5))
            .fill(gradient)
            .frame(width: 350, height: 200)
            .background(Color.gray.opacity(0.15))
    }
}
