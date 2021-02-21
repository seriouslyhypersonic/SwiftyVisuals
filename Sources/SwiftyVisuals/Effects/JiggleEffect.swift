//
//  JiggleEffect.swift
//
//  Created by Nuno Alves de Sousa on 10/10/2020.
//
import SwiftUI

/// Creates a 2D rotation from animatable angle data  in the interval [0,  A] mapped to the interval
/// [-A/2, A/2] where A is the rotation amplitude
public struct JiggleEffect: GeometryEffect {
    let amplitude: Double
    var angle: Double
    public var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    public init(amplitude: Angle, angle: Angle) {
        self.amplitude = amplitude.radians
        self.angle = angle.radians
    }
    
    public func effectValue(size: CGSize) -> ProjectionTransform {
        let rotation = amplitude / 2 * sin( 2 * .pi / amplitude * angle)
        
        let affineTransform = CGAffineTransform(
            translationX: size.width * 0.5,
            y: size.height * 0.5
        )
        .rotated(by: CGFloat(rotation))
        .translatedBy(x: -size.width * 0.5, y: -size.height * 0.5)
        
        return ProjectionTransform(affineTransform)
    }
}
