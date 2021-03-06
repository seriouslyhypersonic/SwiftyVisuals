//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 06/03/2021.
//

import SwiftUI

// A container that only stores objects conforming to ShapeStyle
struct AnyShapeStyleContainer {
    var content: Any
    var fillStyle: FillStyle
    
    init<T: ShapeStyle>(style: T, fillStyle: FillStyle) {
        self.content = style
        self.fillStyle = fillStyle
    }
    
    var angularGradient: AngularGradient? { content as? AngularGradient}
    var backgroundStyle: BackgroundStyle? { content as? BackgroundStyle}
    var color: Color? { content as? Color}
    var foregroundStyle: ForegroundStyle? { content as? ForegroundStyle}
    var imagePaint: ImagePaint? { content as? ImagePaint}
    var linearGradient: LinearGradient? { content as? LinearGradient}
    var radialGradient: RadialGradient? { content as? RadialGradient}
}
