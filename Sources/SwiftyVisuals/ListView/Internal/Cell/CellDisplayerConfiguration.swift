//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 21/02/2021.
//

import SwiftUI

extension CellDisplayer {
    struct Configuration {
        var isHeader = false
        var deleteButtonConfiguration: DeleteButton.Configuration = .init()
        var editingClipShape: AnyShape = Rectangle().eraseToAnyShape()
        var shadowRadius: CGFloat? = 15
        var jiggleAmplitude: Angle = .zero
        var jiggleAnimation: JiggleAnimation = .init()
        var editingBackground: AnyView = Blur(style: .systemUltraThinMaterial).eraseToAnyView()
        
        static let draggingScale: CGFloat = 1.075
        
        struct PressToDrag {
            static let minimumDuration: Double = 0.10
            static let maximumDistance: CGFloat = 500
            static let minimumDistance: CGFloat = 0
        }
        
        struct JiggleAnimation {
            var duration: Double = 0.35
            var on: Animation { Animation.linear(duration: duration).repeatForever(autoreverses: false) }
            var off: Animation { .easeInOut(duration: 0.10) }
        }
    }
}
