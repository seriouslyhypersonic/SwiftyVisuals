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
    func toPointInChartFrame(chartDomain: LineChart.Bounds, frameSize: CGSize) -> CGPoint {
        CGPoint(x: (self.x - chartDomain.minX) / chartDomain.dx * frameSize.width,
                y: frameSize.height - (self.y - chartDomain.minY) / chartDomain.dy * frameSize.height
        )
    }
}

extension DataValue {
    // Convert a DataValue to a height value that can be used as the y coordinate of a CGPoint to be
    // plotted in the Chart frame using the screen coordinate system
    func toValueInChartFrame(minY: CGFloat, maxY: CGFloat, frameHeight: CGFloat) -> CGFloat {
        frameHeight - (self.y - minY) / (maxY - minY) * frameHeight
    }
}
