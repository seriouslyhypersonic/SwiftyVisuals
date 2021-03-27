//
//  View+SaveBounds.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 15/02/2021.
//

import SwiftUI

public extension View {
    /// Save the frame of the current view in a binding whenever its dimensions or position  changes
    /// - Parameters:
    ///   - rect: a binding to store the view frame
    ///   - coordinateSpace: the coordinate space relative to which the frame dimensions are computed
    func saveFrame(in rect: Binding<CGRect>, coordinateSpace: CoordinateSpace = .global) -> some View
    {
        self
            .background(
                GeometryReader { geo in
                    Color.clear.onChange(of: geo.frame(in: coordinateSpace)) { bounds in
                        rect.wrappedValue = bounds
                    }
                }
            )
    }
    
    /// Save a  frame coordinate of the current view in a binding whenever its value changes
    /// - Parameters:
    ///   - coordinate: a `KeyPath` to the particular coordinate to store
    ///   - value: a binding to store the frame coordinate
    ///   - coordinateSpace: the coordinate space relative to which the frame coordinates are computed
    func saveFrame(
        _ coordinate: KeyPath<CGRect, CGFloat>,
        in value: Binding<CGFloat>,
        coordinateSpace: CoordinateSpace = .global) -> some View
    {
        self
            .background(
                GeometryReader { geo in
                    Color.clear.onChange(of: geo.frame(in: coordinateSpace)[keyPath: coordinate] ) { bound in
                        value.wrappedValue = bound
                    }
                }
            )
    }
    
    /// Check if the frame of the current view is vertically or horizontally within the limits of the device's screen
    func frame(isVisible: Binding<Bool>, axis: Axis = .vertical) -> some View {
        self.background(
            GeometryReader { geo in
                Color.clear.onChange(of: geo.frame(in: .global)) { frame in
                    switch axis {
                    case .vertical:
                        isVisible.wrappedValue = frame.maxY.isBetween(min: 0, max: Screen.heigth) ||
                            frame.minY.isBetween(min: 0, max: Screen.heigth)
                    case .horizontal:
                        isVisible.wrappedValue = frame.minX.isBetween(min: 0, max: Screen.width) ||
                            frame.maxX.isBetween(min: 0, max: Screen.width)
                    }
                }
            }
        )
    }
}
