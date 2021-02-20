//
//  TwistableButtonStyle.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 17/02/2021.
//

import SwiftUI

/// The style of a button that can be rotated, scaled and has a shadow while pressed
public protocol TwistableButtonStyle: ButtonStyle {
    var rotation: Angle { get }
    var scale: CGFloat { get }
    var shadowRadius: CGFloat { get }
    
    func twistableLabel(from configuration: Configuration) -> AnyView
}

public extension TwistableButtonStyle {
    func twistableLabel(from configuration: Configuration) -> AnyView {
        twist(label: configuration.label, with: configuration)
    }
    
    func twist<Label: View>(label: Label, with configuration: Configuration) -> AnyView {
        label
            .rotationEffect(configuration.isPressed ? rotation : .zero)
            .scaleEffect(configuration.isPressed ? scale : 1)
            .shadow(radius: configuration.isPressed ? shadowRadius : 0)
            .eraseToAnyView()
    }
}
