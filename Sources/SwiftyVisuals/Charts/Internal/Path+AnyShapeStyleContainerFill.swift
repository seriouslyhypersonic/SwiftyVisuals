//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 06/03/2021.
//

import SwiftUI

extension Path {
    // A way to apply a fill to a Path using ShapeStyle stored in a "type-erased" container
    @ViewBuilder func fill(  _ anyStyle: AnyShapeStyleContainer) -> some View
    {
        self.ifLetElseNothing(anyStyle.angularGradient) { $0.fill($1, style: anyStyle.fillStyle) }
        self.ifLetElseNothing(anyStyle.backgroundStyle) { $0.fill($1, style:  anyStyle.fillStyle) }
        self.ifLetElseNothing(anyStyle.color) { $0.fill($1, style:  anyStyle.fillStyle) }
        self.ifLetElseNothing(anyStyle.foregroundStyle) { $0.fill($1, style:  anyStyle.fillStyle) }
        self.ifLetElseNothing(anyStyle.imagePaint) { $0.fill($1, style:  anyStyle.fillStyle) }
        self.ifLetElseNothing(anyStyle.linearGradient) { $0.fill($1, style:  anyStyle.fillStyle) }
        self.ifLetElseNothing(anyStyle.radialGradient) { $0.fill($1, style:  anyStyle.fillStyle) }
    }
}
