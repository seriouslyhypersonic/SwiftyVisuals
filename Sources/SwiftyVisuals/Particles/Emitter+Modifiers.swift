//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 14/03/2021.
//

import SwiftUI

public extension Emitter {
    func creation(point: UnitPoint = .center, range: CGSize = .zero) -> Self {
        self.modify(\.configuration.creationPoint, value: point)
            .modify(\.configuration.creationRange, value: range)
    }
    
    func colors(_ colors: [Color], blendMode: BlendMode = .multiply) -> Self {
        self.modify(\.configuration.colors, value: colors)
            .modify(\.configuration.blendMode, value: blendMode)
    }
    
    func angle(_ angle: Angle = .zero, range: Angle = .zero) -> Self {
        self.modify(\.configuration.angle, value: angle)
            .modify(\.configuration.angleRange, value: range)
    }
    
    func opacity(_ opacity: Double = 1, range: Double = 0, speed: Double = 0) -> Self {
        self.modify(\.configuration.opacity, value: opacity)
            .modify(\.configuration.opacityRange, value: range)
            .modify(\.configuration.opacitySpeed, value: speed)
    }
    
    func rotation(_ rotation: Angle = .zero, range: Angle = .zero, speed: Angle = .zero) -> Self {
        self.modify(\.configuration.rotation, value: rotation)
            .modify(\.configuration.rotationRange, value: range)
            .modify(\.configuration.rotationSpeed, value: speed)
    }
    
    func scale(_ scale: CGFloat = 1, range: CGFloat = 0, speed: CGFloat = 0) -> Self {
        self.modify(\.configuration.scale, value: scale)
            .modify(\.configuration.scaleRange, value: range)
            .modify(\.configuration.scaleSpeed, value: speed)
    }
    
    func speed(_ speed: Double = 50, range: Double = 0) -> Self {
        self.modify(\.configuration.speed, value: speed)
            .modify(\.configuration.speedRange, value: range)
    }
    
    func animation(
        _ animation: Animation = Animation.linear(duration: 1).repeatForever(autoreverses: false),
        delayThreshold: Double = 0) -> Self
    {
        self.modify(\.configuration.animation, value: animation)
            .modify(\.configuration.animationDelayThreshold, value: delayThreshold)
    }
}

public extension Emitter {
    init<Particles>(particles: Particles, count: Int) where Particles: Collection, Particles.Element: View {
        self.particles = particles.map { $0.eraseToAnyView() }
        self.particleCount = count
    }
    
    init(images: [String], count: Int) {
        self.particles = images.map { Image($0, bundle: .main).eraseToAnyView() }
        self.particleCount = count
    }
}

public extension Emitter {
    struct Configuration {
        var creationPoint: UnitPoint = .center
        var creationRange: CGSize = .zero
        
        var colors: [Color] = [.white]
        var blendMode: BlendMode = .normal
        
        var angle: Angle = .zero
        var angleRange: Angle = .zero
        
        var opacity: Double = 1
        var opacityRange: Double = 0
        var opacitySpeed: Double = 0
        
        var rotation: Angle = .zero
        var rotationRange: Angle = .zero
        var rotationSpeed: Angle = .zero
        
        var scale: CGFloat = 1
        var scaleRange: CGFloat = 0
        var scaleSpeed: CGFloat = 0
        
        var speed: Double = 50
        var speedRange: Double = 0
        
        var animation: Animation = Animation.linear(duration: 1).repeatForever(autoreverses: false)
        var animationDelayThreshold: Double = 0.0
    }
}
