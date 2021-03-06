//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 05/03/2021.
//

import SwiftUI

extension LineChart {
    /// A structure representing the bounds of chart
    public struct Bounds {
        var minX: CGFloat
        var maxX: CGFloat
        var minY: CGFloat
        var maxY: CGFloat
        
        // Range of the plotting domain
        var dx: CGFloat { maxX - minX }
        var dy: CGFloat { maxY - minY }
    }
}
