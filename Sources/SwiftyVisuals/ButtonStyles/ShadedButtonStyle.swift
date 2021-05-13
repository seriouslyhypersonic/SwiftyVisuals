//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 02/03/2021.
//

import SwiftUI

public struct ShadedButtonStyle: ButtonStyle {
    let color: Color
    let opacity: Double
    
    public init(color: Color = .primary, opacity: Double = 0.1) {
        self.color = color
        self.opacity = opacity
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(color.opacity(configuration.isPressed ? opacity : 0))
            .contentShape(Rectangle())
    }
}
