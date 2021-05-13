//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 10/05/2021.
//

import SwiftUI

/// A circular, twistable, button with a custom background
public struct CircleButtonStyle: TwistableButtonStyle {
    public let rotation: Angle
    public let scale: CGFloat
    public let shadowRadius: CGFloat
    
    let clipShape = Circle()
    let background: AnyView?
    let padding: Padding
    
    public init(
        padding: Padding = .init(horizontal: 7, vertical: 7),
        rotation: Angle = .degrees(90),
        scale: CGFloat = 1.5,
        shadowRadius: CGFloat = 10)
    {
        self.rotation = rotation
        self.scale = scale
        self.shadowRadius = shadowRadius
        self.background = nil
        self.padding = padding
    }
    
    public init<Background: View>(
        background: Background,
        padding: Padding = .init(horizontal: 7, vertical: 7),
        rotation: Angle = .degrees(90),
        scale: CGFloat = 1.5,
        shadowRadius: CGFloat = 10)
    {
        self.rotation = rotation
        self.scale = scale
        self.shadowRadius = shadowRadius
        
        self.background = background.eraseToAnyView()
        self.padding = padding
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        twist(
            label: styleButton(
                configuration: configuration,
                label: configuration.label,
                padding: padding,
                background: background,
                clipShape: clipShape),
            with: configuration)
    }
}
