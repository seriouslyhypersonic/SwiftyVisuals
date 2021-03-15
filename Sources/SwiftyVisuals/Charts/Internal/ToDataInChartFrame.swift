//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 06/03/2021.
//

import SwiftUI

extension DataPoint {
    // Convert a DataPoint to a CGPoint that can be plotted in the Chart frame using the
    // screen coordinate system
    func toPointInChartFrame(domain: LineChart.Bounds, frameSize: CGSize) -> CGPoint {
        CGPoint(x: ChartFrame.xInChartFrame(x, minX: domain.minX, maxX: domain.maxX, width: frameSize.width),
                y: ChartFrame.yInChartFrame(y, minY: domain.minY, maxY: domain.maxY, height: frameSize.height)
        )
    }
}

extension DataValue {
    // Convert a DataValue to a height value that can be used as the y coordinate of a CGPoint to be
    // plotted in the Chart frame using the screen coordinate system
    func toValueInChartFrame(minY: CGFloat, maxY: CGFloat, frameHeight: CGFloat) -> CGFloat {
        ChartFrame.yInChartFrame(y, minY: minY, maxY: maxY, height: frameHeight)
    }
}

struct ChartFrame {
    enum Direction { case x, y }
    
    static func xInChartFrame(_ x: CGFloat, minX: CGFloat, maxX: CGFloat, width: CGFloat) -> CGFloat {
        (x - minX) / (maxX - minX) * width
    }
    
    static func yInChartFrame(_ y: CGFloat, minY: CGFloat, maxY: CGFloat, height: CGFloat) -> CGFloat {
        height - (y - minY) / (maxY - minY) * height
    }
}
