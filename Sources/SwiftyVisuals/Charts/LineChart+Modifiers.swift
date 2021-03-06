//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 05/03/2021.
//

import SwiftUI

public extension LineChart {
    func stepSize(x: CGFloat) -> Self {
        modify(\.configuration.stepSize, value: x)
    }
    
    func limitis(
        minX: CGFloat? = nil,
        maxX: CGFloat? = nil,
        minY: CGFloat? = nil,
        maxY: CGFloat? = nil) -> Self
    {
        self.modify(\.configuration.minX, value: minX)
            .modify(\.configuration.maxX, value: maxX)
            .modify(\.configuration.minY, value: minY)
            .modify(\.configuration.maxY, value: maxY)
    }
    
    func line(radius: CGFloat, animation: Animation? = nil) -> Self {
        var chart = modify(\.configuration.lineRadius, value: radius)
        if let animation = animation {
            chart = chart.line(animation: animation)
        }
        return chart
    }
    
    func stroke(lineWidth: CGFloat) -> Self {
        modify(\.configuration.lineWidth, value: lineWidth)
    }
    
    func line(animation: Animation) -> Self {
        modify(\.configuration.lineAnimation, value: animation)
    }
    
    func stroke<Content: ShapeStyle>(_ content: Content, lineWidth: CGFloat = 1) -> Self {
        self.modify(\.configuration.strokeStyle,
                    value: AnyShapeStyleContainer(style: content, fillStyle: FillStyle())
        )
        .modify(\.configuration.lineWidth, value: lineWidth)
    }
    
    func fill(animatableMask: AnyAnimatableMask, animation: Animation? = nil) -> Self {
        var chart = modify(\.configuration.mask, value: animatableMask)
        if let animation = animation {
            chart = chart.fill(animation: animation)
        }
        return chart
    }
    
    func fill(transition: AnyTransition, animation: Animation? = nil) -> Self {
        var chart = modify(\.configuration.fillTransition, value: transition)
        if let animation = animation {
            chart = chart.fill(animation: animation)
        }
        return chart
    }
    
    func fill(animation: Animation) -> Self {
        modify(\.configuration.fillAnimation, value: animation)
    }
    
    func fill<Content: ShapeStyle>(_ content: Content, fillStyle: FillStyle = FillStyle()) -> Self {
        modify(
            \.configuration.fillStyle,
            value: AnyShapeStyleContainer(style: content, fillStyle: fillStyle))
    }
}
