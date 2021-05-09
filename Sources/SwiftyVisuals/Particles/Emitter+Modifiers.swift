//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 14/03/2021.
//

import SwiftUI

public extension Emitter {
    /// Configure the particle creation region
    /// - Parameters:
    ///   - point: unit point representing the position of the emitter
    ///   - range: the area around the center of the emitter where particles can be emitted from
    func creation(point: UnitPoint = .center, range: CGSize = .zero) -> Self {
        self.modify(\.configuration.creationPoint, value: point)
            .modify(\.configuration.creationRange, value: range)
    }
    
    
    /// Add a color multiplication effect to the particles
    /// - Parameters:
    ///   - colors: an array of colors that are randomly used for the color multiplication effect
    ///   - blendMode: blend mode for compositing each particle view with overlapping particles
    func colors(_ colors: [Color], blendMode: BlendMode = .multiply) -> Self {
        self.modify(\.configuration.colors, value: colors)
            .modify(\.configuration.blendMode, value: blendMode)
    }
    
    /// Configure the direction of the particle movement
    /// - Parameters:
    ///   - angle: main direction of the particle movement
    ///   - range: maximum allowable angular deviation from the main direction of the particle movement
    func angle(_ angle: Angle = .zero, range: Angle = .zero) -> Self {
        self.modify(\.configuration.angle, value: angle)
            .modify(\.configuration.angleRange, value: range)
    }
    
    /// Configura particle opacity
    /// - Parameters:
    ///   - opacity: main particle opacity
    ///   - range: maximum amplitude for random opacity deviation
    ///   - speed: opacity delta
    func opacity(_ opacity: Double = 1, range: Double = 0, speed: Double = 0) -> Self {
        self.modify(\.configuration.opacity, value: opacity)
            .modify(\.configuration.opacityRange, value: range)
            .modify(\.configuration.opacitySpeed, value: speed)
    }
    
    /// Configure particle roation
    /// - Parameters:
    ///   - rotation: main particle rotation
    ///   - range: maximum amplitude for random particle rotation
    ///   - speed: rotation delta
    func rotation(_ rotation: Angle = .zero, range: Angle = .zero, speed: Angle = .zero) -> Self {
        self.modify(\.configuration.rotation, value: rotation)
            .modify(\.configuration.rotationRange, value: range)
            .modify(\.configuration.rotationSpeed, value: speed)
    }
    
    /// Configure particle scale
    /// - Parameters:
    ///   - scale: main particle scale factor
    ///   - range: maximum aplitude for random particle scaling
    ///   - speed: scale factor delta
    func scale(_ scale: CGFloat = 1, range: CGFloat = 0, speed: CGFloat = 0) -> Self {
        self.modify(\.configuration.scale, value: scale)
            .modify(\.configuration.scaleRange, value: range)
            .modify(\.configuration.scaleSpeed, value: speed)
    }
    
    /// Configure particle speed
    /// - Parameters:
    ///   - speed: main particle speed
    ///   - range: maximum amplitude for random speed deviation
    func speed(_ speed: Double = 50, range: Double = 0) -> Self {
        self.modify(\.configuration.speed, value: speed)
            .modify(\.configuration.speedRange, value: range)
    }
    
    /// Configure the emitter animation
    /// - Parameters:
    ///   - animation: the animation used to transition between initial and final particle states of position, opacity, rotation and scale
    ///   - delayThreshold: maximum random delay for particle animation
    func animation(
        _ animation: Animation = Animation.linear(duration: 1).repeatForever(autoreverses: false),
        delayThreshold: Double = 0) -> Self
    {
        self.modify(\.configuration.animation, value: animation)
            .modify(\.configuration.animationDelayThreshold, value: delayThreshold)
    }
    
    /// Configure emitter update policy on size change
    /// - Parameter update: if set to true, the emitter generates a new set of random particles when it detects a change in size of
    /// the  container view.
    /// - Note: the default emitter update policy is not to react to size changes
    func onSizeChange(update: Bool ) -> Self {
        self.modify(\.configuration.updateOnSizeChange, value: update)
    }
}
