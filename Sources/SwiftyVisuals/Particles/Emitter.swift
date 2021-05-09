//
//  SwiftUIView.swift
//  
//
//  Created by Nuno Alves de Sousa on 13/03/2021.
//

import SwiftUI

/// A view that is a configurable source of a particle system
public struct Emitter: View {
    var particles: [AnyView]
    var particleCount: Int
    var configuration = Configuration()
    
    @State private var particleViews: [Particle] = []
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(particleViews) { particle in
                    particle
                    .colorMultiply(configuration.colors.randomElement() ?? .white)
                    .blendMode(configuration.blendMode)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .onAppear { generateParticles(size: geometry.size) }
            .if(configuration.updateOnSizeChange) {
                $0.onChange(of: geometry.size, perform: generateParticles)
            }
            
        }
    }
    
    private func generateParticles(size: CGSize) {
        particleViews = (0..<particleCount).map { _ in
            Particle(
                particle: particles.randomElement()!,
                position: position(size: size),
                opacity: makeOpacity(),
                rotation: makeRotation(),
                scale: makeScale(),
                animation: configuration.animation
                    .delay(.random(in: 0...configuration.animationDelayThreshold))
            )
        }
    }
    
    private func position(size: CGSize) -> ParticleState<CGPoint> {
        let halfCreationRangeWidth = configuration.creationRange.width / 2
        let halfCreationRangeHeight = configuration.creationRange.height / 2
        
        let creationOffsetX = CGFloat.random(in: -halfCreationRangeWidth...halfCreationRangeWidth)
        let creationOffsetY = CGFloat.random(in: -halfCreationRangeHeight...halfCreationRangeHeight)
        
        let startX = Double(size.width * (configuration.creationPoint.x + creationOffsetX))
        let startY = Double(size.height * (configuration.creationPoint.y + creationOffsetY))
        let start = CGPoint(x: startX, y: startY)
        
        let halfSpeedRange = configuration.speedRange / 2
        let actualSpeed = configuration.speed + Double.random(in: -halfSpeedRange...halfSpeedRange)
        
        let halfAngleRange = configuration.angleRange.radians / 2
        let actualDirection = configuration.angle.radians + Double.random(in: -halfAngleRange...halfAngleRange)
        
        let endX = startX + cos(actualDirection - .pi / 2 ) * actualSpeed
        let endY = startY + sin(actualDirection - .pi / 2) * actualSpeed
        let end = CGPoint(x: endX, y: endY)
        
        return ParticleState(start: start, end: end)
    }
    
    private func makeOpacity() -> ParticleState<Double> {
        let randomOpacity = random(from: configuration.opacityRange)
        return ParticleState(
            start: configuration.opacity + randomOpacity,
            end: configuration.opacity + configuration.opacitySpeed + randomOpacity)
    }
    
    private func makeScale() -> ParticleState<CGFloat> {
        let randomScale = random(from: configuration.scaleRange)
        return ParticleState(
            start: configuration.scale + randomScale,
            end: configuration.scale + configuration.scaleSpeed + randomScale)
    }
    
    private func makeRotation() -> ParticleState<Angle> {
        let randomRotation = random(from: configuration.rotationRange.radians)
        let randomRotationAngle = Angle(radians: randomRotation)
        return ParticleState(start: configuration.rotation + randomRotationAngle,
                             end: configuration.rotation + configuration.rotationSpeed + randomRotationAngle)
    }
    
    func random<T: BinaryFloatingPoint>(from range: T) -> T where T.RawSignificand: FixedWidthInteger {
        let amplitude = T(range / 2)
        return T.random(in: -amplitude...amplitude)
    }
}

struct Emitter_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Emitter(particles: [Image("spark", bundle: .module)], count: 100)
                .creation(range: CGSize(width: 0.2, height: 0))
                .angle(range: .degrees(180))
                .colors([.red, .orange, .purple, .blue], blendMode: .screen)
                .opacity(range: 0.4, speed: -1.1)
                .scale(0.4, range: 2, speed: 0.4)
                .speed(200, range: 80)
                .animation(Animation.easeOut(duration: 2).repeatForever(autoreverses: false))
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}
