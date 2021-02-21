//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 20/02/2021.
//

import SwiftUI

public extension View {
    /// Applies a 2D rotation from animatable angle data  in the interval [0,  A] mapped to the interval
    /// [-A/2, A/2] where A is the rotation amplitude
    /// - Parameters:
    ///   - amplitude: the rotation amplitude
    ///   - angle: the animatable angle data in the interval [0, A]
    @ViewBuilder func jiggleEffect(amplitude: Angle, angle: Angle) -> some View {
        switch amplitude {
        case .zero: self
        default: modifier(JiggleEffect(amplitude: amplitude, angle: angle))
        }
    }
}
