//
//  BlurView.swift
//
//  Created by Nuno Alves de Sousa on 10/10/2020.
//
import SwiftUI

/// A SwiftUI wrapper around a `UIVIsualEffectView` where a `UIBlurEffect` is presented
public struct Blur: UIViewRepresentable {
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
        Background() {
            ZStack {
                Text(loremIpsum)
                    .font(Font.title.bold())
                    .foregroundColor(.white)
                
                Blur(style: .systemUltraThinMaterial)
                    .frame(height: 375)
                    .cornerRadius(25)
            }
            .padding(.horizontal, 25)
        }
    }
    
    static let loremIpsum =
    """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur maximus placerat nunc, ut \
    ultrices est. Praesent arcu purus, gravida vitae nisl eu, tristique volutpat leo. Nulla quis \
    sodales enim. Curabitur rhoncus congue ligula, a pellentesque libero convallis in. Nunc \
    eleifend venenatis varius. Quisque gravida commodo elit, eu tempor diam commodo in. Duis eu \
    nisi leo.
    """
}


