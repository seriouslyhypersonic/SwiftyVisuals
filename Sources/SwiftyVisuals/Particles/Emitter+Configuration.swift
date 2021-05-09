//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 09/05/2021.
//

import SwiftUI

extension Emitter {
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
        
        var updateOnSizeChange = false
    }
}
