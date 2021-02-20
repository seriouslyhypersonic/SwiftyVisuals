//
//  DestructiveButtonStyle.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 16/02/2021.
//

import SwiftUI

public struct DestructiveButtonStyle: TwistableButtonStyle {
    public let rotation: Angle
    public let scale: CGFloat
    public let shadowRadius: CGFloat
    
    public init(rotation: Angle = .degrees(-90), scale: CGFloat = 1.5, shadowRadius: CGFloat = 10) {
        self.rotation = rotation
        self.scale = scale
        self.shadowRadius = shadowRadius
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        twistableLabel(from: configuration)
            .foregroundColor(configuration.isPressed ? Color(#colorLiteral(red: 0.717164319, green: 0.107281192, blue: 0.006196144465, alpha: 1)) : .red)
    }
}
