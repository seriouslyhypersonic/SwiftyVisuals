//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 05/03/2021.
//

import SwiftUI

extension LineChart {
    struct Configuration {
        var stepSize: CGFloat? = nil
        var lineRadius: CGFloat = 0.37
        
        var minX: CGFloat? = nil
        var maxX: CGFloat? = nil
        var minY: CGFloat? = nil
        var maxY: CGFloat? = nil
        
        var xLineMinY: CGFloat? = nil
        var xLineMaxY: CGFloat? = nil
        var yLineMinX: CGFloat? = nil
        var yLineMaxX: CGFloat? = nil
        
        var gridVerticalPosition: VerticalPosition = .front
        var grid = Grid()
        
        var mask: AnyAnimatableMask? = nil
        var fillAnimation: Animation? = nil
        var fillTransition: AnyTransition? = nil
        var fillStyle = AnyShapeStyleContainer(style: Color.clear, fillStyle: FillStyle())
        
        var lineAnimation: Animation? = nil
        var lineShapeStyle = AnyShapeStyleContainer(style: Color.primary, fillStyle: FillStyle())
        var lineStrokeStyle = StrokeStyle(lineWidth: 2)
        
        var xLineShapeStyle = AnyShapeStyleContainer(style: Color.secondary, fillStyle: FillStyle())
        var xLineStrokeStyle = StrokeStyle(lineWidth: 0.25, dash: [5, 2])
        
        var yLineShapeStyle = AnyShapeStyleContainer(style: Color.secondary, fillStyle: FillStyle())
        var yLineStrokeStyle = StrokeStyle(lineWidth: 0.25)
        
        var xLabelFont: Font = Font.caption.bold()
        var xLabelColor: Color = .primary
        var xLabelXOffset: CGFloat = 2
        var xLabelYOffset:CGFloat = 10
        
        var yLabelFont: Font = Font.caption.bold()
        var yLabelColor: Color = .primary
        var yLabelXOffset: CGFloat = -10
        var yLabelYOffset:CGFloat = 0
        
        var xLabels: [AnyView]? = nil
        var yLabels: [AnyView]? = nil
    }
}

extension LineChart {
    struct Grid {
        var xTicks: [CGFloat] = []
        var yTicks: [CGFloat] = []
        
        func xLines(minY: CGFloat, maxY: CGFloat) -> [[DataPoint]] {
            xTicks.map {
                [DataPoint(x: $0, y: minY), DataPoint(x: $0, y: maxY)]
            }
        }
        
        func yLines(minX: CGFloat, maxX: CGFloat) -> [[DataPoint]] {
            yTicks.map {
                [DataPoint(x: minX, y: $0), DataPoint(x: maxX, y: $0)]
            }
        }
    }
}

public extension LineChart {
    enum VerticalPosition: Double {
        case back = 0
        case front = 2
        
        static let middle: Double = 1
    }
}


