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
        
        var mask: AnyAnimatableMask? = nil
        var fillAnimation: Animation? = nil
        var lineAnimation: Animation? = nil
        var fillStyle = AnyShapeStyleContainer(style: Color.clear, fillStyle: FillStyle())
        var strokeStyle = AnyShapeStyleContainer(style: Color.primary, fillStyle: FillStyle())
        var lineWidth: CGFloat = 1
        var fillTransition: AnyTransition? = nil
    }
}
