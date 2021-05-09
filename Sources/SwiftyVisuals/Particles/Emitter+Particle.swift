//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 08/05/2021.
//

import SwiftUI

extension Emitter {
    struct Particle: View, Identifiable {
        @Environment(\.scenePhase) private var scenePhase
        @State private var isActive = false
        
        let id = UUID()
        
        let particle: AnyView
        let position: ParticleState<CGPoint>
        let opacity: ParticleState<Double>
        let rotation: ParticleState<Angle>
        let scale: ParticleState<CGFloat>
        let animation: Animation
        
        var body: some View {
            particle
                .opacity(isActive ? opacity.end : opacity.start)
                .scaleEffect(isActive ? scale.end : scale.start)
                .rotationEffect(isActive ? rotation.end : rotation.start)
                .position(isActive ? position.end : position.start)
                .onAppear {
                    withAnimation(animation) {
                        self.isActive = true
                    }
                }
        }
    }
}
