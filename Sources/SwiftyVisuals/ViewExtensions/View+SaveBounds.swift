//
//  View+SaveBounds.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 15/02/2021.
//

import SwiftUI

extension View {
    /// Save the frame of the current view in a binding whenever its dimensions change
    /// - Parameters:
    ///   - rect: a binding to store the view frame
    ///   - coordinateSpace: the coordinate space relative to which the frame dimensions are computed
    func saveBounds(in rect: Binding<CGRect>, coordinateSpace: CoordinateSpace = .global) -> some View
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
}
