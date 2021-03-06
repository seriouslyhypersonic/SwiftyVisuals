//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 06/03/2021.
//

import SwiftUI

extension Shape {
    // A way to apply a stroke to a shape using ShapeStyle stored in a "type-erased" container
    @ViewBuilder func stroke(_ anyStyle: AnyShapeStyleContainer, lineWidth: CGFloat) -> some View
    {
        self.ifLetElseNothing(anyStyle.angularGradient) { $0.stroke($1, lineWidth: lineWidth) }
        self.ifLetElseNothing(anyStyle.backgroundStyle) { $0.stroke($1, lineWidth: lineWidth) }
        self.ifLetElseNothing(anyStyle.color)           { $0.stroke($1, lineWidth: lineWidth) }
        self.ifLetElseNothing(anyStyle.foregroundStyle) { $0.stroke($1, lineWidth: lineWidth) }
        self.ifLetElseNothing(anyStyle.imagePaint)      { $0.stroke($1, lineWidth: lineWidth) }
        self.ifLetElseNothing(anyStyle.linearGradient)  { $0.stroke($1, lineWidth: lineWidth) }
        self.ifLetElseNothing(anyStyle.radialGradient)  { $0.stroke($1, lineWidth: lineWidth) }
    }
}
