//
//  BlurView.swift
//
//  Created by Nuno Alves de Sousa on 10/10/2020.
//
import SwiftUI

/// A SwiftUI wrapper around a `UIVIsualEffectView` where a `UIBlurEffect` is presented
public struct BlurView: UIViewRepresentable {
    public typealias UIViewType = UIVisualEffectView
    
    let style: UIBlurEffect.Style
    
    public init(style: UIBlurEffect.Style = .systemMaterial) { self.style = style }
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct BlurView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient.purpleToGreenDiagonally
                .ignoresSafeArea()
            Text("SwiftUI")
                .font(.system(size: 100, weight: .black))
                .foregroundColor(.white)
                .rotationEffect(.degrees(-45))
            BlurView(style: .systemUltraThinMaterial)
                .frame(width: Screen.width * 0.9, height: 350)
                .cornerRadius(25)
        }
    }
}
