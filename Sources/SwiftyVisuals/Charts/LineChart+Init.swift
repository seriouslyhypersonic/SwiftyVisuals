//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 05/03/2021.
//

import SwiftUI

public extension LineChart {
    /// Create a `LineChart` from an array of `DataPoint`s
    /// - Parameter points: the array of `DataPoit`s to plot
    init(points: [DataPoint]) {
        self.data = .init(points)
    }
    
    /// Create a `LineChart` from an array of `CGPoint`s
    /// - Parameter points: the array of `CGPoint`s to plot
    init(cgPoints: [CGPoint]) {
        let points = cgPoints.map { DataPoint(x: $0.x, y: $0.y) }
        self.init(points: points)
    }
    
    /// Create a `LineChart` from an array of `DataValue`s
    /// - Parameter points: the array of `DataValue`s to plot
    init(values: [DataValue]) {
        self.data = .init(values)
    }
    
    /// Create a `LineChart` from an array of `CGFloat` y-values
    /// - Parameter points: the array of y-values to plot
    init(cgFloats: [CGFloat]) {
        let values = cgFloats.map { DataValue(y: $0) }
        self.init(values: values)
    }
}
