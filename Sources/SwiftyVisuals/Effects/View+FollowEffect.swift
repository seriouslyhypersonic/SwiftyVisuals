//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 01/05/2021.
//

import SwiftUI

public extension View {
    /// Translate a view along a path
    /// - Parameters:
    ///   - path: path along wich to translate the view
    ///   - length: percentage of path length used for the follow effect
    ///   - rotate: rotate view according to path direction
    ///   - currentPosition: current position olong the path
    ///   - currentDirection: direction of the current position
    ///   - currentProgress: percentage o thef path length completed by the effect
    func followEffect(
        path: Path,
        length: CGFloat = 0,
        rotate: Bool = false,
        currentPosition: Binding<CGPoint>? = nil,
        currentDirection: Binding<Angle>? = nil,
        currentProgress: Binding<Double>? = nil
    ) -> some View
    {
        self.modifier(FollowEffect(
                        path: path,
                        length: length,
                        rotate: rotate,
                        currentPosition: currentPosition,
                        currentDirection: currentDirection,
                        currentProgress: currentProgress))
    }
}
