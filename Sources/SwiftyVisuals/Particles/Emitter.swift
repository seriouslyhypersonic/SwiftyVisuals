//
//  SwiftUIView.swift
//  
//
//  Created by Nuno Alves de Sousa on 13/03/2021.
//

import SwiftUI

public struct Emitter: View {
    private struct Particle: View {
        @Environment(\.scenePhase) private var scenePhase
        @State private var isActive = false
        
        let particle: AnyView
        let position: ParticleState<CGPoint>
        let opacity: ParticleState<Double>
        let rotation: ParticleState<Angle>
        let scale: ParticleState<CGFloat>
        
        var body: some View {
            particle
                .opacity(isActive ? opacity.end : opacity.start)
                .scaleEffect(isActive ? scale.end : scale.start)
                .rotationEffect(isActive ? rotation.end : rotation.start)
                .position(isActive ? position.end : position.start)
                .onAppear { self.isActive = true }
        }
    }
    
    private struct ParticleState<T> {
        var start: T
        var end: T
    }
    
    var particles: [AnyView]
    var particleCount: Int
    
    var configuration = Configuration()
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(0..<particleCount, id: \.self) { index in
                    Particle(
                        particle: particles.randomElement()!,
                        position: position(in: geo),
                        opacity: makeOpacity(),
                        rotation: makeRotation(),
                        scale: makeScale()
                    )
                    .animation(configuration.animation.delay(.random(in: 0...configuration.animationDelayThreshold)))
                    .colorMultiply(configuration.colors.randomElement() ?? .white)
                    .blendMode(configuration.blendMode)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
    
    private func position(in proxy: GeometryProxy) -> ParticleState<CGPoint> {
        let halfCreationRangeWidth = configuration.creationRange.width / 2
        let halfCreationRangeHeight = configuration.creationRange.height / 2
        
        let creationOffsetX = CGFloat.random(in: -halfCreationRangeWidth...halfCreationRangeWidth)
        let creationOffsetY = CGFloat.random(in: -halfCreationRangeHeight...halfCreationRangeHeight)
        
        let startX = Double(proxy.size.width * (configuration.creationPoint.x + creationOffsetX))
        let startY = Double(proxy.size.height * (configuration.creationPoint.y + creationOffsetY))
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
