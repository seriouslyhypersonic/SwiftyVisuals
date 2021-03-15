//
//  SwiftUIView.swift
//  
//
//  Created by Nuno Alves de Sousa on 11/03/2021.
//

import SwiftUI

public struct Wave: Shape {
    var amplitude: CGFloat
    var phase: Double
    var cycles: CGFloat
    var isClosed: Bool
    
    public var animatableData: Double {
        get { phase }
        set { self.phase = newValue }
    }
    
    public init(amplitude: CGFloat, phase: Angle, cycles: CGFloat = 1, isClosed: Bool = true) {
        self.amplitude = amplitude
        self.phase = phase.radians
        self.cycles = cycles
        self.isClosed = isClosed
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let left = CGPoint(x: rect.minY, y: f(x: rect.minY, width: rect.width) )
        path.move(to: left)
        
        for x in stride(from: rect.minY, through: rect.width, by: 1) {
            let y = f(x: x, width: rect.width)
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        if isClosed {
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minY, y: rect.maxY))
        }
        
        return path
    }
    
    func f(x: CGFloat, width: CGFloat) -> CGFloat {
        let relativeX: CGFloat = cycles * x * (2 * CGFloat.pi / width)
        let sine = CGFloat(sin(relativeX + CGFloat(phase)))
        return amplitude/2 * sine
    }
}

struct WaveMaskModifier: AnimatableModifier {
    
    var pct: CGFloat
    
    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .mask(
                GeometryReader { geo in
                    VStack {
                        Spacer()
                        ZStack {
                            Wave(amplitude: 30, phase: Angle(degrees: (Double(pct) * 720 * -1) + 45))
                                .opacity(0.5)
                                .scaleEffect(x: 1.0, y: 1.2, anchor: .center)
                                .offset(x: 0, y: 30)
                            Wave(amplitude: 30, phase: Angle(degrees: Double(pct) * 720))
                                .scaleEffect(x: 1.0, y: 1.2, anchor: .center)
                                .offset(x: 0, y: 30)
                        }
                        .frame(height: geo.size.height * pct, alignment: .bottom)
                    }
                    
                }
            )
    }
}

extension AnyTransition {
    static let waveMask = AnyTransition.asymmetric(insertion:
        AnyTransition.modifier(active: WaveMaskModifier(pct: 0), identity: WaveMaskModifier(pct: 1))
        , removal:
            .scale(scale: 1.1)
    )
}


struct Wave_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            Wave(amplitude: 20, phase: .degrees(-90), isClosed: false)
                .stroke(Color.blue, lineWidth: 2)
                .frame(height: 20)
            
            Wave(amplitude: 20, phase: .degrees(0), cycles: 4, isClosed: false)
                .stroke(Color.blue, lineWidth: 2)
                .frame(height: 20)
            
            Wave(amplitude: 20, phase: .degrees(90), cycles: 8, isClosed: false)
                .stroke(Color.blue, lineWidth: 2)
                .frame(height: 20)
            
            Wave(amplitude: 20, phase: .degrees(0))
                .fill(Color.blue)
                .frame(height: 50)
        }
    }
}
