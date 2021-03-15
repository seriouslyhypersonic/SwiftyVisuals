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
        if let animation = animation { chart = chart.line(animation: animation) }
        return chart
    }
    
    func line(strokeStyle: StrokeStyle) -> Self {
        modify(\.configuration.lineStrokeStyle, value: strokeStyle)
    }
    
    func line(lineWidth: CGFloat) -> Self {
        modify(\.configuration.lineStrokeStyle.lineWidth, value: lineWidth)
    }
    
    func line(animation: Animation) -> Self {
        modify(\.configuration.lineAnimation, value: animation)
    }
    
//    func line<Content: ShapeStyle>(_ content: Content, lineWidth: CGFloat? = nil) -> Self {
//        var chart = modify(
//            \.configuration.lineShapeStyle,
//            value: AnyShapeStyleContainer(style: content, fillStyle: FillStyle()))
//            
//        if let lineWidth = lineWidth {
//            chart = chart.line(lineWidth: lineWidth)
//        }
//        return chart
//    }
    
    func line<Content: ShapeStyle>(_ content: Content, strokeStyle: StrokeStyle? = nil) -> Self {
        var chart = modify(
            \.configuration.lineShapeStyle,
            value: AnyShapeStyleContainer(style: content, fillStyle: FillStyle()))
        if let strokeStyle = strokeStyle { chart = chart.line(strokeStyle: strokeStyle) }
        return chart
    }
    
    func fill(animatableMask: AnyAnimatableMask, animation: Animation? = nil) -> Self {
        var chart = modify(\.configuration.mask, value: animatableMask)
        if let animation = animation { chart = chart.fill(animation: animation) }
        return chart
    }
    
    func fill(transition: AnyTransition, animation: Animation? = nil) -> Self {
        var chart = modify(\.configuration.fillTransition, value: transition)
        if let animation = animation { chart = chart.fill(animation: animation) }
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
    
    func xGrid(_ values: [CGFloat]) -> Self {
        modify(\.configuration.grid.xTicks, value: values)
    }
    
    func xGrid<T: BinaryInteger>(from min: T, through max: T, by amount: T) -> Self {
        let xTicks = Array(stride(from: CGFloat(min), through: CGFloat(max), by: CGFloat(amount)))
        return modify(\.configuration.grid.xTicks, value: xTicks)
    }
    
    func xGrid<T: BinaryFloatingPoint>(from min: T, through max: T, by amount: T) -> Self {
        let xTicks = Array(stride(from: CGFloat(min), through: CGFloat(max), by: CGFloat(amount)))
        return modify(\.configuration.grid.xTicks, value: xTicks)
    }
    
    func yGrid(_ values: [CGFloat]) -> Self {
        modify(\.configuration.grid.yTicks, value: values)
    }
    
    func yGrid<T: BinaryInteger>(from min: T, through max: T, by amount: T) -> Self {
        let yTicks = Array(stride(from: CGFloat(min), through: CGFloat(max), by: CGFloat(amount)))
        return modify(\.configuration.grid.yTicks, value: yTicks)
    }
    
    func yGrid<T: BinaryFloatingPoint>(from min: T, through max: T, by amount: T) -> Self {
        let yTicks = Array(stride(from: CGFloat(min), through: CGFloat(max), by: CGFloat(amount)))
        return modify(\.configuration.grid.yTicks, value: yTicks)
    }
    
    func grid(position: LineChart.VerticalPosition = .back) -> Self {
        modify(\.configuration.gridVerticalPosition, value: position)
    }
    
    func xGridLines(strokeStyle: StrokeStyle) -> Self {
        modify(\.configuration.xLineStrokeStyle, value: strokeStyle)
    }
    
    func xGridLines(lineWidth: CGFloat) -> Self {
        modify(\.configuration.xLineStrokeStyle.lineWidth, value: lineWidth)
    }
    
    func xGridLines<Content: ShapeStyle>(_ content: Content, strokeStyle: StrokeStyle? = nil) -> Self {
        var chart = modify(
            \.configuration.xLineShapeStyle,
            value: AnyShapeStyleContainer(style: content, fillStyle: FillStyle()))
        if let strokeStyle = strokeStyle { chart = chart.xGridLines(strokeStyle: strokeStyle) }
        
        return chart
    }
    
    func yGridLines(strokeStyle: StrokeStyle) -> Self {
        modify(\.configuration.yLineStrokeStyle, value: strokeStyle)
    }
    
    func yGridLines(lineWidth: CGFloat) -> Self {
        modify(\.configuration.yLineStrokeStyle.lineWidth, value: lineWidth)
    }
    
    func yGridLines<Content: ShapeStyle>(_ content: Content, strokeStyle: StrokeStyle? = nil) -> Self {
        var chart = modify(
            \.configuration.yLineShapeStyle,
            value: AnyShapeStyleContainer(style: content, fillStyle: FillStyle()))
        if let strokeStyle = strokeStyle { chart = chart.yGridLines(strokeStyle: strokeStyle) }
        return chart
    }
    
    func xLabels(font: Font? = nil, color: Color? = nil) -> Self {
        var chart = self
        if let font = font { chart.configuration.xLabelFont = font }
        if let color = color { chart.configuration.xLabelColor = color }
        return chart
    }
    
    func xLabelOffset(x: CGFloat? = nil, y: CGFloat? = nil) -> Self {
        var chart = self
        if let x = x { chart.configuration.xLabelXOffset = x }
        if let y = y { chart.configuration.xLabelYOffset = y }
        return chart
    }
    
    func yLabels(font: Font? = nil, color: Color? = nil) -> Self {
        var chart = self
        if let font = font { chart.configuration.yLabelFont = font }
        if let color = color { chart.configuration.yLabelColor = color }
        return chart
    }
    
    func yLabelOffset(x: CGFloat? = nil, y: CGFloat? = nil) -> Self {
        var chart = self
        if let x = x { chart.configuration.yLabelXOffset = x }
        if let y = y { chart.configuration.yLabelYOffset = y }
        return chart
    }
    
    func labels<Label: View>(x xLabels: [Label]? = nil, y yLabels: [Label]? = nil) -> Self {
        var chart = self
        if let xLabels = xLabels { chart.configuration.xLabels = xLabels.map { $0.eraseToAnyView()} }
        if let yLabels = yLabels { chart.configuration.yLabels = yLabels.map { $0.eraseToAnyView()} }
        return chart
    }
}
